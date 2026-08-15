import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fooderlich/components/components.dart';
import 'package:fooderlich/models/models.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class GroceryItemScreen extends StatefulWidget {
  const GroceryItemScreen({
    required this.onCreate, required this.onUpdate, super.key,
    this.originalItem,
    this.index = -1,
  })  : isUpdating = (originalItem != null);

  final Function(GroceryItem) onCreate;
  final Function(GroceryItem, int) onUpdate;
  final GroceryItem? originalItem;
  final bool isUpdating;
  final int index;

  static MaterialPage page({
    required Function(GroceryItem) onCreate, required Function(GroceryItem, int) onUpdate, GroceryItem? item,
    int index = -1,
  }) {
    return MaterialPage(
      name: FooderlichPages.groceryItemDetails,
      key: ValueKey(FooderlichPages.groceryItemDetails),
      child: GroceryItemScreen(
        originalItem: item,
        index: index,
        onCreate: onCreate,
        onUpdate: onUpdate,
      ),
    );
  }

  @override
  State<GroceryItemScreen> createState() => _GroceryItemScreenState();
}

class _GroceryItemScreenState extends State<GroceryItemScreen> {
  final _nameController = TextEditingController();
  String _name = '';
  Importance _importance = Importance.low;
  DateTime _dueDate = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Color _currentColor = Colors.green;
  int _currentSliderValue = 0;

  @override
  void initState() {
    final originalItem = widget.originalItem;

    if (originalItem != null) {
      _nameController.text = originalItem.name;
      _name = originalItem.name;
      _currentSliderValue = originalItem.quantity;
      _importance = originalItem.importance;
      _currentColor = originalItem.color;
      final date = originalItem.date;
      _dueDate = date;
      _timeOfDay = TimeOfDay(
        hour: date.hour,
        minute: date.minute,
      );
    }

    _nameController.addListener(
      () => setState(
        () => _name = _nameController.text,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Grocery item',
          style: GoogleFonts.lato(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              final groceryItem = GroceryItem(
                id: widget.originalItem?.id ?? const Uuid().v1(),
                name: _nameController.text,
                importance: _importance,
                color: _currentColor,
                quantity: _currentSliderValue,
                date: DateTime(
                  _dueDate.year,
                  _dueDate.month,
                  _dueDate.day,
                  _dueDate.hour,
                  _dueDate.minute,
                ),
              );

              if (widget.isUpdating) {
                widget.onUpdate(groceryItem, widget.index);
              } else {
                widget.onCreate(groceryItem);
              }
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNameField(),
          _buildImportanceField(),
          _buildDateField(context),
          _buildTimeField(context),
          const SizedBox(height: 10),
          _buildColorPicker(context),
          const SizedBox(height: 10),
          _buildQuantityField(),
          const SizedBox(height: 10),
          GroceryTile(
            item: GroceryItem(
              id: 'previewMode',
              name: _name,
              importance: _importance,
              color: _currentColor,
              quantity: _currentSliderValue,
              date: DateTime(
                _dueDate.year,
                _dueDate.month,
                _dueDate.day,
                _dueDate.hour,
                _dueDate.minute,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Item name',
          style: GoogleFonts.lato(fontSize: 28),
        ),
        TextField(
          controller: _nameController,
          cursorColor: _currentColor,
          decoration: InputDecoration(
            hintText: 'E.g. Apples, Banana, 1 Bag of salt',
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImportanceField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Importance',
          style: GoogleFonts.lato(fontSize: 28),
        ),
        Wrap(
          spacing: 30,
          children: [
            ChoiceChip(
              label: const Text(
                'low',
                style: TextStyle(color: Colors.white),
              ),
              selected: _importance == Importance.low,
              selectedColor: Colors.black,
              onSelected: (_) => setState(
                () => _importance = Importance.low,
              ),
            ),
            ChoiceChip(
              label: const Text(
                'medium',
                style: TextStyle(color: Colors.white),
              ),
              selected: _importance == Importance.medium,
              selectedColor: Colors.black,
              onSelected: (_) => setState(
                () => _importance = Importance.medium,
              ),
            ),
            ChoiceChip(
              label: const Text(
                'high',
                style: TextStyle(color: Colors.white),
              ),
              selected: _importance == Importance.high,
              selectedColor: Colors.black,
              onSelected: (_) => setState(
                () => _importance = Importance.high,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Date',
              style: GoogleFonts.lato(fontSize: 28),
            ),
            TextButton(
              onPressed: () async {
                final currentDate = DateTime.now();
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: currentDate,
                  firstDate: currentDate,
                  lastDate: DateTime(currentDate.year + 5),
                );
                if (selectedDate != null) {
                  setState(() => _dueDate = selectedDate);
                }
              },
              child: const Text('Select'),
            ),
          ],
        ),
        Text(DateFormat('yyyy-MM-dd').format(_dueDate)),
      ],
    );
  }

  Widget _buildTimeField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Time of day',
              style: GoogleFonts.lato(fontSize: 28),
            ),
            TextButton(
              onPressed: () async {
                final timeOfDay = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (timeOfDay != null) {
                  setState(() => _timeOfDay = timeOfDay);
                }
              },
              child: const Text('Select'),
            ),
          ],
        ),
        Text(_timeOfDay.format(context)),
      ],
    );
  }

  Widget _buildColorPicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 50,
              width: 10,
              color: _currentColor,
            ),
            const SizedBox(width: 8),
            Text(
              'Color',
              style: GoogleFonts.lato(fontSize: 28),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: BlockPicker(
                    pickerColor: Colors.white,
                    onColorChanged: (color) => setState(
                      () => _currentColor = color,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Save'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Text('Select'),
        ),
      ],
    );
  }

  Widget _buildQuantityField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              'Quantity',
              style: GoogleFonts.lato(fontSize: 28),
            ),
            const SizedBox(width: 16),
            Text(
              _currentSliderValue.toString(),
              style: GoogleFonts.lato(fontSize: 18),
            ),
          ],
        ),
        Slider(
          max: 100,
          divisions: 100,
          value: _currentSliderValue.toDouble(),
          label: _currentSliderValue.toString(),
          inactiveColor: _currentColor.withValues(alpha: 0.5),
          activeColor: _currentColor,
          onChanged: (value) => setState(
            () => _currentSliderValue = value.toInt(),
          ),
        ),
      ],
    );
  }
}
