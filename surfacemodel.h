#ifndef SURFACEMODEL_H
#define SURFACEMODEL_H

#include <QAbstractListModel>

class surfaceModelList;

class SurfaceModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(surfaceModelList *list READ list WRITE setList)

public:
    explicit SurfaceModel(QObject *parent = nullptr);

    enum{
        xRole = Qt::UserRole,
        yRole,
        zRole
    };
    Q_INVOKABLE void updateModel();
    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;

    virtual QHash<int, QByteArray> roleNames() const override;


    surfaceModelList *list() const;
    void setList(surfaceModelList *list);

private:
    surfaceModelList *mList;
};

#endif // SURFACEMODEL_H
