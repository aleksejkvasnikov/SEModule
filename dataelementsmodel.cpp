#include "dataelementsmodel.h"
#include <qdebug.h>
dataElementsModel::dataElementsModel(QObject *parent):
    QAbstractListModel(parent)
{
    for(int i=0; i<3; i++)
        for(int j=0; j<3; j++)
            for(int k=0; k<3; k++)
            {
                setsomeData(i,j,k);
            }
    qDebug()<<"im here";
}
int dataElementsModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid()) {
        return 0;
    }
    return data_vector[0].size();
}
void dataElementsModel::setsomeData(double x, double y, double z)
{
    vector<double> rowvec;
    rowvec.reserve(3);
    rowvec.push_back(x);
    rowvec.push_back(y);
    rowvec.push_back(z);
    qDebug() << rowvec;
    data_vector.push_back(rowvec);
}
QVariant dataElementsModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid()) {
        return QVariant();
    }
    qDebug()<< index.row() << role;
    switch (role) {
    case rowRole:
        {
      //  qDebug()<< QVariant(data_vector[index.row()][0]);
        return QVariant(data_vector[index.row()][0]);
        }
    case columnRole:
    {
       // qDebug()<< QVariant(data_vector[index.row()][1]);
        return QVariant(data_vector[index.row()][1]);
    }
    case yPosRole:
    {
      //  qDebug()<< QVariant(data_vector[index.row()][2]);
        return QVariant(data_vector[index.row()][2]);
    }
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> dataElementsModel::roleNames() const
{
    QHash<int, QByteArray> roles = QAbstractListModel::roleNames();
    roles[rowRole] = "longitude";
    roles[columnRole] = "latitude";
    roles[yPosRole] = "pop_density";
    return roles;
}
void dataElementsModel::add()
{
    beginInsertRows(QModelIndex(), data_vector[0].size(), data_vector[0].size());
    endInsertRows();
    QModelIndex index = createIndex(0, 0, static_cast<void *>(0));
    emit dataChanged(index, index);
}
