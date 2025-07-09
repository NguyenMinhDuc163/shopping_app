import '../../../init.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});
  static const String routeName = '/paymentMethodScreen';
  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  @override
  Widget build(BuildContext context) {
    return FunctionScreenTemplate();
  }
}
