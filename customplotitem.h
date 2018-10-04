#pragma once
#include "qcustomplot.h"
#include <QtQuick>
//#include "surfacemodellist.h"
class QCustomPlot;

class CustomPlotItem : public QQuickPaintedItem
{
    Q_OBJECT
   // Q_PROPERTY(surfaceModelList *list READ list WRITE setList)
public:
    CustomPlotItem( QQuickItem* parent = 0 );
    virtual ~CustomPlotItem();
    void paint( QPainter* painter );

    Q_INVOKABLE void initCustomPlot(QVector<double> x, QVector<double> y);
   // Q_INVOKABLE void setData();
   // surfaceModelList *list() const;
   // void setList(surfaceModelList *list);

protected:
    void routeMouseEvents( QMouseEvent* event );
    void routeWheelEvents(QWheelEvent* event);
    virtual void mousePressEvent( QMouseEvent* event );
    virtual void mouseReleaseEvent( QMouseEvent* event );
    virtual void mouseMoveEvent( QMouseEvent* event );
    virtual void mouseDoubleClickEvent( QMouseEvent* event );
    virtual void wheelEvent(QWheelEvent* event);
    void setupQuadraticDemo( QCustomPlot* customPlot, QVector<double> x, QVector<double> y);

private:
    QCustomPlot*         m_CustomPlot;
  //  surfaceModelList *mList;
private slots:
    void graphClicked( QCPAbstractPlottable* plottable );
    void onCustomReplot();
    void updateCustomPlotSize();

};
