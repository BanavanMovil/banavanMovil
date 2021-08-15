import 'package:banavanmov/model/personnel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PersonnelListTileWidget extends StatelessWidget {
  final Personnel personnel;
  final bool seleccionado;
  final ValueChanged<Personnel> onSelectedChanged;
  PersonnelListTileWidget(
      {Key key, this.personnel, this.seleccionado, this.onSelectedChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = seleccionado
        ? TextStyle(
            fontSize: 18,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          )
        : TextStyle(fontSize: 18);
    return ListTile(
      onTap: () => onSelectedChanged(personnel),
      title: Text(
        'Id: ' + personnel.id.toString(),
        style: style,
      ),
      subtitle: Text(
        personnel.nombres + " " + personnel.apellidos,
        style: style,
      ),
      trailing: seleccionado
          ? Icon(Icons.check, color: Colors.green, size: 26)
          : null,
    );
  }
}
