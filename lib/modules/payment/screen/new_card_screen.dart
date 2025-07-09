import '../../../init.dart';

class NewCardScreen extends StatefulWidget {
  const NewCardScreen({super.key});
  static const String routeName = '/newCardScreen';
  @override
  State<NewCardScreen> createState() => _NewCardScreenState();
}

class _NewCardScreenState extends State<NewCardScreen> {
  @override
  Widget build(BuildContext context) {
    return FunctionScreenTemplate();
  }
}
