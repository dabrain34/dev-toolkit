#include "mainwindow.h"
#include <QDebug>


MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent)
{
    setMouseTracking(true);
}

MainWindow::~MainWindow()
{
}

void MainWindow::mouseMoveEvent(QMouseEvent *ev)
{
  qDebug() << ev->pos();
}

void MainWindow::mousePressEvent(QMouseEvent *ev)
{
  qDebug() << "mousePressEvent";
}

void MainWindow::mouseReleaseEvent(QMouseEvent *ev)
{
  qDebug() << "mouseReleaseEvent";
}
