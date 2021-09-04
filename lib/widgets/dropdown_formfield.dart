library dropdown_formfield;



import 'package:flutter/material.dart';
import 'package:sharvaanimatrimony/conts/colors.dart';

class DropDownFormField extends FormField<dynamic> {
  final String titleText;
  final String hintText;
  final bool required;
  final String errorText;
  final dynamic value;
  final List dataSource;
  final String textField;
  final String valueField;
  final Function onChanged;
  final bool filled;
  final EdgeInsets contentPadding;
  final dynamic focusNode;
  final dynamic labelStyle;
  final dynamic fillcolor;
  final dynamic decoration;
  final dynamic itemStyle;

  DropDownFormField(
      {FormFieldSetter<dynamic> onSaved,
      FormFieldValidator<dynamic> validator,
      bool autovalidate = false,
      this.titleText,
      this.hintText = 'Select one option',
      this.required = false,
      this.errorText = 'Please select one option',
      this.value,
      this.dataSource,
        this.decoration,
      this.textField,
      this.valueField,
      this.onChanged,
      this.filled = true,
        this.fillcolor,
      this.contentPadding = const EdgeInsets.symmetric(vertical:4,horizontal: 10),
        this.focusNode,
        this.labelStyle = const TextStyle(color: set1_dark_blue,fontSize: 24,),
        this.itemStyle = const TextStyle(fontSize: 20),
      }
  )
      : super(
          onSaved: onSaved,
          validator: validator,
          // ignore: deprecated_member_use
          autovalidate: autovalidate,
          initialValue: value == '' ? null : value,
          builder: (FormFieldState<dynamic> state) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InputDecorator(
                    decoration: decoration !=null?decoration:InputDecoration(
                      contentPadding: contentPadding,
                      labelText: titleText,
                      labelStyle: labelStyle,
                      filled: filled,
                      fillColor: fillcolor,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.grey[400], width: 1),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: error, width: 2),
                      ),
                      errorStyle: TextStyle(color: error,fontWeight: FontWeight.bold,fontFamily: "Montserrat"),

                    ),
                    child: DropdownButtonHideUnderline(

                      child: DropdownButton<dynamic>(


                        dropdownColor: set1_light_blue_light,
                        focusNode: focusNode,
                        elevation: 8,
                        hint: Text(
                          hintText,
                          style: TextStyle(color: Colors.grey[600],fontSize: 20),
                        ),
                        value: value == '' ? null : value,
                        onChanged: (dynamic newValue) {
                          state.didChange(newValue);
                          onChanged(newValue);
                        },
                        items: dataSource.map((item) {
                          return DropdownMenuItem<dynamic>(
                            value: item[valueField],
                            child: Text(item[textField],style: itemStyle,),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: state.hasError ? 5.0 : 0.0),
                  Text(
                    state.hasError ? state.errorText : '',
                    style: TextStyle(color: error_light, fontSize: state.hasError ? 12.0 : 0.0),
                  ),
                ],
              ),
            );
          },
        );
}
