import 'package:admin_grad_pro/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableWidget extends StatelessWidget {
  final Widget child;
  final String id;
  final Function(SlidableAction action) onDismissed;
  final int index;
  // 1 : cart : favoirite / delete
  // 2 : unFavorite
  // 3 : productmnagnent : product edit / delete

  SlidableWidget({
    @required this.child,
    @required this.id,
    @required this.onDismissed,
    @required this.index,
  });
  @override
  Widget build(BuildContext context) {
    return Slidable(
      child: child,
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      actions: <Widget>[
        if (index == 1)
          IconSlideAction(
            caption: 'Delete',
            closeOnTap: true,
            color: Colors.grey,
            icon: Icons.remove_shopping_cart_outlined,
            onTap: () => onDismissed(SlidableAction.delete),
          ),
        if (index == 1)
          IconSlideAction(
            caption: 'Love It',
            color: Colors.red,
            icon: Icons.favorite_outline,
            onTap: () => onDismissed(SlidableAction.favorite),
          ),
        if (index == 2)
          IconSlideAction(
            caption: 'UnLove It',
            color: Colors.red,
            icon: Icons.favorite_outline,
            onTap: () => onDismissed(SlidableAction.unFavorite),
          ),
        if (index == 3)
          IconSlideAction(
            caption: 'Delete',
            closeOnTap: true,
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => onDismissed(SlidableAction.AdminProductDelete),
          ),
        if (index == 3)
          IconSlideAction(
            caption: 'Edit',
            color: Colors.grey,
            icon: Icons.edit,
            onTap: () => onDismissed(SlidableAction.edit),
          ),
      ],
    );
  }
}
