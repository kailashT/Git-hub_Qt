#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include "sqlitedb.h"
#include <QMessageBox>

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();
    int test_db();

protected:
    void resizeEvent(QResizeEvent *event);

private slots:
    void on_get_Action_clicked();

private:
    Ui::MainWindow *ui;
    sqlitedb *db_edit;
};

#endif // MAINWINDOW_H
