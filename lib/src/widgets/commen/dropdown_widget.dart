import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class DropDownWidget<T> extends StatefulWidget {
  final List<T> list;
  final T selectedValue;
  final Function callBack;
  const DropDownWidget({
    super.key,
    required this.list,
    required this.selectedValue,
    required this.callBack,
  });

  @override
  State<DropDownWidget<T>> createState() => _DropDownWidgetState<T>();
}

class _DropDownWidgetState<T> extends State<DropDownWidget<T>>
    with SingleTickerProviderStateMixin {
  late T drowdownvalue;
  final log = Logger('DropDownWidget');
  @override
  void initState() {
    super.initState();
    drowdownvalue = widget.selectedValue;
  }

  @override
  void didUpdateWidget(covariant DropDownWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (drowdownvalue != widget.selectedValue) {
      drowdownvalue = widget.selectedValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    log.info('build');

    return DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        key: Key('${T}DropdownKey'),
        value: drowdownvalue,
        borderRadius: BorderRadius.circular(15),
        selectedItemBuilder: (context) {
          return widget.list
              .map<DropdownMenuItem<T>>(
                (e) => DropdownMenuItem<T>(
                  key: Key('${e.toString()}ItemKey'),
                  value: e,
                  child: SizedBox(
                    width: (T == int) ? 50 : 100,
                    child: Center(
                      child: Text(e.toString()),
                    ),
                  ),
                ),
              )
              .toList();
        },
        items: widget.list
            .map<DropdownMenuItem<T>>(
              (e) => DropdownMenuItem<T>(
                value: e,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(e.toString()),
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() {
              FocusScope.of(context).requestFocus(FocusNode());
              drowdownvalue = value;
              widget.callBack(value);
            });
          }
        },
      ),
    );
  }
}
