// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:states_rebuilder/states_rebuilder.dart';



// class _TheState {}

// var _theState = RM.inject(() => _TheState());

// class _SelectRow extends StatelessWidget {
//   final Function(bool) onChange;
//   final bool selected;
//   final String text;

//   const _SelectRow(
//       {Key? key,
//       required this.onChange,
//       required this.selected,
//       required this.text})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         onChange(!selected);
//         _theState.notify();
//       },
//       child: Container(
//         height: kMinInteractiveDimension,
//         child: Row(
//           children: [
//             Checkbox(
//                 activeColor: Colors.green,
//                 value: selected,
//                 onChanged: (x) {
//                   onChange(x!);
//                   _theState.notify();
//                 }),
//             Text(text)
//           ],
//         ),
//       ),
//     );
//   }
// }

// class DropDownMultiSelect extends StatefulWidget {
//   // final List<TransportsModel> options;
// // 
//   // final List<TransportsModel> selectedValues;
// // 
//   // final Function(List<TransportsModel>) onChanged;

//   final bool isDense;

//   final bool enabled;

//   final InputDecoration? decoration;

//   final String? whenEmpty;

//   // final Widget Function(List<TransportsModel> selectedValues)? childBuilder;

//   final Widget Function(String option)? menuItembuilder;

//   // final String? Function(TransportsModel? selectedOptions)? validator;

//   final bool readOnly;

//   final Widget? icon;

//   final TextStyle? hintStyle;

//   final Widget? hint;

//   const DropDownMultiSelect({
//     Key? key,
//     // required this.options,
//     // required this.selectedValues,
//     // required this.onChanged,
//     this.whenEmpty,
//     this.icon,
//     this.hint,
//     this.hintStyle,
//     // this.childBuilder,
//     this.menuItembuilder,
//     this.isDense = true,
//     this.enabled = true,
//     this.decoration,
//     // this.validator,
//     this.readOnly = false,
//   }) : super(key: key);

//   @override
//   _DropDownMultiSelectState createState() => _DropDownMultiSelectState();
// }

// class _DropDownMultiSelectState extends State<DropDownMultiSelect> {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.topCenter,
//       children: [
//         Theme(
//           data: Theme.of(context).copyWith(),
//           child: Container(
//             height: 52,
//             // child: DropdownButtonFormField<TransportsModel>(
//             child: DropdownButtonFormField<>(
//               validator: widget.validator,
//               hint: widget.hint,
//               style: widget.hintStyle,
//               icon: widget.icon,
//               decoration: widget.decoration != null
//                   ? widget.decoration
//                   : InputDecoration(
//                       filled: true,
//                       fillColor: AppColors.white,
//                       errorBorder: InputBorder.none,
//                       border: InputBorder.none,
//                       disabledBorder: InputBorder.none,
//                       enabledBorder: InputBorder.none,
//                       focusedBorder: InputBorder.none,
//                       isDense: true,
//                       contentPadding: EdgeInsets.symmetric(
//                         vertical: 15,
//                         horizontal: 10,
//                       ),
//                     ),
//               isDense: widget.isDense,
//               onChanged: widget.enabled ? (x) {} : null,
//               isExpanded: false,
//               value: widget.selectedValues.length > 0
//                   ? widget.selectedValues[0]
//                   : null,
//               selectedItemBuilder: (context) {
//                 return widget.options
//                     .map(
//                       (e) => DropdownMenuItem(
//                         child: Container(),
//                       ),
//                     )
//                     .toList();
//               },
//               items: widget.options
//                   .map(
//                     (x) => DropdownMenuItem(
//                       child: _theState.rebuild(() {
//                         return widget.menuItembuilder != null
//                             ? widget.menuItembuilder!(x.title ?? '')
//                             : _SelectRow(
//                                 selected: widget.selectedValues.contains(x),
//                                 text: x.title ?? '',
//                                 onChange: (isSelected) {
//                                   if (isSelected) {
//                                     log(widget.selectedValues.length
//                                         .toString());
//                                     List<TransportsModel> ns =
//                                         widget.selectedValues;
//                                     ns.add(x);
//                                     widget.onChanged(ns);
//                                   } else {
//                                     var ns = widget.selectedValues;
//                                     ns.remove(x);
//                                     widget.onChanged(ns);
//                                   }
//                                 },
//                               );
//                       }),
//                       value: x,
//                       onTap: !widget.readOnly
//                           ? () {
//                               if (widget.selectedValues.contains(x)) {
//                                 var ns = widget.selectedValues;
//                                 ns.remove(x);
//                                 widget.onChanged(ns);
//                               } else {
//                                 var ns = widget.selectedValues;
//                                 ns.add(x);
//                                 widget.onChanged(ns);
//                               }
//                             }
//                           : null,
//                     ),
//                   )
//                   .toList(),
//             ),
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.only(top: 16),
//           child: Row(
//             children: [
//               _theState.rebuild(
//                 () => widget.childBuilder != null
//                     ? widget.childBuilder!(widget.selectedValues)
//                     : Flexible(
//                         child: Padding(
//                           padding: widget.decoration != null
//                               ? widget.decoration!.contentPadding != null
//                                   ? widget.decoration!.contentPadding!
//                                   : EdgeInsets.symmetric(
//                                       horizontal: 10,
//                                     )
//                               : EdgeInsets.symmetric(
//                                   horizontal: 10,
//                                 ),
//                           child: Padding(
//                             padding: EdgeInsets.only(
//                               right: 20,
//                             ),
//                             child: Text(
//                               widget.selectedValues.length > 0
//                                   ? widget.selectedValues
//                                       .map(
//                                         (e) => e.title ?? '',
//                                       )
//                                       .reduce(
//                                         (a, b) => a + ' , ' + b,
//                                       )
//                                   : widget.whenEmpty ?? '',
//                               style: GoogleFonts.oxygen(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: (widget.selectedValues.length > 0)
//                                     ? AppColors.blackishgray
//                                     : AppColors.grey,
//                               ),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ),
//                       ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
