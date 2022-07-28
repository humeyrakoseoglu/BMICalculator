/// @author Humeyra Koseoglu

import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _bmiCalculation = 0;
  String _index = 'Enter your values';
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'BMI Calculator',
            style: TextStyle(
              color: accentColor,
              fontWeight: FontWeight.w500,
              fontSize: 30,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: mainColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),

                ////Enter Height
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    children: [
                      Text(
                        'Height:',
                        style: TextStyle(
                          color: Colors.white.withOpacity(.7),
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextField(
                        controller: _heightController,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(.7),
                        ),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'cm',
                          hintStyle: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //Enter Weight
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    children: [
                      Text(
                        'Weight:',
                        style: TextStyle(
                          color: Colors.white.withOpacity(.7),
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextField(
                        controller: _weightController,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(.7),
                        ),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'cm',
                          hintStyle: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(.8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            //Calculate Button
            OutlinedButton(
                onPressed: () {
                  _calculate();
                },
                child: Text('CALCULATE',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ))),
            const SizedBox(height: 10),

            //Reset Button
            OutlinedButton(
                onPressed: () {
                  _heightController.clear();
                  _weightController.clear();
                  setState(() {
                    _bmiCalculation = 0.00;
                    _index = 'Enter your values';
                  });
                },
                child: Text('RESET',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ))),
            const SizedBox(height: 30),

            //Show BMI Result
            Text(
              _bmiCalculation.toStringAsFixed(2),
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: accentColor,
              ),
            ),
            const SizedBox(height: 50),
            Visibility(
              visible: _index.isNotEmpty,
              child: Text(
                _index,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  color: accentColor,
                ),
              ),
            ),
            const SizedBox(height: 50),

            //Show example BMI Model Photo
            Image.asset("images/bmi_result.png"),
          ],
        ),
      ),
    );
  }

  // Calculate method for BMI
  void _calculate() {
    final double? height = double.tryParse(_heightController.value.text);
    final double? weight = double.tryParse(_weightController.value.text);

    // Check if the inputs are valid
    if (height == null || height <= 0 || weight == null || weight <= 0) {
      setState(() {
        _index = "Values must be positive numbers";
      });
      return;
    }

    setState(() {
      _bmiCalculation = weight / ((height / 100) * (height / 100));
      if (_bmiCalculation < 18.5) {
        _index = "UNDERWEIGHT";
      } else if (_bmiCalculation < 25) {
        _index = 'NORMAL';
      } else if (_bmiCalculation < 30) {
        _index = 'OVERWEIGHT';
      } else {
        _index = 'OBESE';
      }
    });
  }
}
