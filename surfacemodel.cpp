#include "surfacemodel.h"
#include "surfacemodellist.h"
#include "QDebug"
SurfaceModel::SurfaceModel(QObject *parent)
    : QAbstractListModel(parent)
    , mList(nullptr)
{
}

void SurfaceModel::updateModel()
{
    for (int i=0; i< mList->items().size();)
    {
        beginRemoveRows(QModelIndex(),i,i);
        mList->items().removeAt(i);
        endRemoveRows();
    }

}

int SurfaceModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid() || !mList)
        return 0;
    return mList->items().size();
}

QVariant SurfaceModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || !mList)
        return QVariant();

    const surfaceModelItem item = mList->items().at(index.row());
    switch(role)
    {
        case xRole:
        {
            return QVariant(item.x);
        }
        case yRole:
        {
            return QVariant(item.y);
        }
        case zRole:
        {
            return QVariant(item.z);
        }
    }
    return QVariant();
}

bool SurfaceModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if(!mList)
        return false;

    surfaceModelItem item = mList->items().at(index.row());
    switch(role)
    {
        case xRole:
        {
            item.x = value.toDouble();
            break;
        }
        case yRole:
        {
            item.y = value.toDouble();
            break;
        }
        case zRole:
        {
            item.z = value.toDouble();
            break;
        }
    }
    if (mList->setItemAt(index.row(), item)) {
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags SurfaceModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable;
}

QHash<int, QByteArray> SurfaceModel::roleNames() const
{
    QHash<int, QByteArray> names;
    names[xRole] = "x";
    names[yRole] = "y";
    names[zRole] = "z";
    return names;
}

surfaceModelList *SurfaceModel::list() const
{
    return mList;
}

void SurfaceModel::setList(surfaceModelList *list)
{
    beginResetModel();
    if (mList) mList->disconnect(this);
    mList = list;
    if(mList){
        connect(mList, &surfaceModelList::preItemAppended, this, [=]()
        {
            const int index = mList->items().size();
            beginInsertRows(QModelIndex(),index,index);
        });
        connect(mList, &surfaceModelList::postItemAppended, this, [=]()
        {
            endInsertRows();
        });
        connect(mList, &surfaceModelList::preItemRemoved, this, [=](int index)
        {
            beginRemoveRows(QModelIndex(),index,index);
        });
        connect(mList, &surfaceModelList::postItemRemoved, this, [=]()
        {
           // endRemoveRows();
            endResetModel();
        });
        connect(mList, &surfaceModelList::preItemsRemoved, this, [=](int index1, int index2)
        {
             // beginRemoveRows(QModelIndex(), index1, index2);
            beginResetModel();
        });
    }
    endResetModel();
}

