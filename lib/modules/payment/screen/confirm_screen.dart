import '../../../init.dart';

class ConfirmScreen extends StatefulWidget {
  const ConfirmScreen({super.key});
  static const String routeName = '/confirmScreen';
  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  @override
  Widget build(BuildContext context) {
    return FunctionScreenTemplate();
  }
}
