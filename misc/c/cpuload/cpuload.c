#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include <sys/time.h>
#define USEC_PER_SEC 1000*1000

static int
get_n_cpus (void)
{
  FILE *cmd = popen ("grep '^processor' /proc/cpuinfo | wc -l", "r");

  if (cmd == NULL)
    return -1;

  unsigned nprocs;
  size_t n;
  char buff[8];

  if ((n = fread (buff, 1, sizeof (buff) - 1, cmd)) <= 0)
    return -1;

  buff[n] = '\0';
  if (sscanf (buff, "%u", &nprocs) != 1)
    return -1;

  pclose (cmd);

  return nprocs;
}

static int
get_cpu_usage ()
{
  static long unsigned last_usage = 0;
  static long unsigned last_idle = 0;
  FILE *f;
  long unsigned user;
  long unsigned nice;
  long unsigned system;
  long unsigned idle;
  long unsigned iowait;
  long unsigned irq;
  long unsigned softirq;
  long unsigned steal;

  long unsigned usage_now;
  long unsigned idle_now;
  double result;

  f = fopen ("/proc/stat", "r");
  fscanf (f, "%*s %lu %lu %lu %lu %lu %lu %lu %lu", &user, &nice, &system,
      &idle, &iowait, &irq, &softirq, &steal);
  fclose (f);

  usage_now = user + nice + system + irq + softirq + steal;
  idle_now = idle + iowait;

  result =
      ((usage_now - last_usage) / (double) (usage_now + idle_now - last_usage -
          last_idle)) * 100;

  last_usage = usage_now;
  last_idle = idle_now;

  return (int) result;
}

double
get_monotonic_time (void)
{
  double time;                  // Milliseconds
  struct timeval tv;
  gettimeofday (&tv, NULL);

  time = (tv.tv_sec) * USEC_PER_SEC + (tv.tv_usec);
  return time;
}

void
doing (int wait_ms)
{
  double end_time;
  double start_time = get_monotonic_time ();
  do {
    end_time = get_monotonic_time ();
  } while ((end_time - start_time) / 1000 < wait_ms);
  return;
}

void *
processing (void *ptr)
{
  int cpu_usage = *(int *) ptr;
  while (1) {
    doing (cpu_usage / 10);
    usleep ((100 - cpu_usage) * 100);
  }

/* the function must return something - NULL will do */
  return NULL;

}

int
main (int argc, char *argv[])
{
  pthread_t waiting_thread;
  unsigned int wait = 50;
  int n_cpus, i;
  if (argc > 1) {
    wait = atoi (argv[1]);
    if (wait >= 100)
      wait = 99;
    printf ("Use %d %% of CPU\n", wait);
  }
  n_cpus = get_n_cpus ();

  printf ("creating %u threads according to the number of cpus: \n", n_cpus);
  for (i = 0; i < n_cpus; i++) {

    if (pthread_create (&waiting_thread, NULL, processing, &wait)) {
      fprintf (stderr, "Error creating thread\n");
      return 1;
    }
  }

  while (1) {
    printf ("%d\n", get_cpu_usage ());
    usleep (USEC_PER_SEC);
  }
}
