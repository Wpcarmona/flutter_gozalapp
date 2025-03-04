import 'package:flutter/material.dart';

class SelectableCard extends StatelessWidget {
  final String text;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableCard({
    Key? key,
    required this.text,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.orange.shade200,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ),
            Checkbox(
              value: isSelected,
              onChanged: (value) => onTap(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              activeColor: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}

class SelectableCardList extends StatefulWidget {
  final List<Map<String, String>> items;
  final Function(String) onItemSelected;

  const SelectableCardList({
    super.key,
    required this.items,
    required this.onItemSelected,
  });

  @override
  SelectableCardListState createState() => SelectableCardListState();
}

class SelectableCardListState extends State<SelectableCardList> {
  String? selectedItem;

  void _onItemTap(String text) {
    setState(() {
      selectedItem = text;
    });
    widget.onItemSelected(text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.items.map((item) {
        return SelectableCard(
          text: item['text']!,
          imagePath: item['imagePath']!,
          isSelected: selectedItem == item['text'],
          onTap: () => _onItemTap(item['text']!),
        );
      }).toList(),
    );
  }
}
