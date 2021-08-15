import 'package:crud/models/data_model.dart';
import 'package:crud/pages/home_page.dart';
import 'package:crud/services/db_service.dart';
import 'package:crud/utils/form_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddEditProduct extends StatefulWidget {
  AddEditProduct({Key key, this.model, this.isEditMode = false})
      : super(key: key);
  ProductModel model;
  bool isEditMode;

  @override
  _AddEditProductState createState() => _AddEditProductState();
}

class _AddEditProductState extends State<AddEditProduct> {
  ProductModel model;
  DBService dbService;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    dbService = new DBService();
    model = new ProductModel();

    if (widget.isEditMode) {
      model = widget.model;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(widget.isEditMode ? "Edit Movie" : "Add Movie"),
      ),
      body: new Form(
        key: globalFormKey,
        child: _formUI(),
      ),
    );
  }

  Widget _formUI() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormHelper.fieldLabel("Movie Name"),
                FormHelper.textInput(
                  context,
                  model.movieName,
                  // ignore: sdk_version_set_literal
                  (value) => {
                    this.model.movieName = value,
                  },
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return 'Please enter Movie Name.';
                    }
                    return null;
                  },
                ),
                FormHelper.fieldLabel("Director Name"),
                FormHelper.textInput(
                  context,
                  model.directorName,
                  // ignore: sdk_version_set_literal
                  (value) => {
                    this.model.directorName = value,
                  },
                  isTextArea: true,
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return 'Please enter Director Name.';
                    }
                    return null;
                  },
                ),
                FormHelper.fieldLabel("Price of the movie"),
                FormHelper.textInput(
                  context,
                  model.price,
                  // ignore: sdk_version_set_literal
                  (value) => {
                    this.model.price = double.parse(value),
                  },
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return 'Please enter price of the movie.';
                    }

                    if (value.toString().isNotEmpty &&
                        double.parse(value.toString()) <= 0) {
                      return 'Please enter valid price.';
                    }
                    return null;
                  },
                ),
                FormHelper.fieldLabel("Select Movie Photo"),
                FormHelper.picPicker(
                  model.productPic,
                  // ignore: sdk_version_set_literal
                  (file) => {
                    setState(
                      () {
                        model.productPic = file.path;
                      },
                    )
                  },
                ),
                btnSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Widget btnSubmit() {
    return new Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          if (validateAndSave()) {
            print(model.toMap());
            if (widget.isEditMode) {
              dbService.updateProduct(model).then((value) {
                FormHelper.showMessage(
                  context,
                  "Movie List",
                  "Data Submitted Successfully",
                  "Ok",
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                );
              });
            } else {
              dbService.addProduct(model).then((value) {
                FormHelper.showMessage(
                  context,
                  "Movie List",
                  "Data Modified Successfully",
                  "Ok",
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                );
              });
            }
          }
        },
        child: Container(
          height: 40.0,
          margin: EdgeInsets.all(10),
          width: 100,
          color: Colors.blueAccent,
          child: Center(
            child: Text(
              "Save Movie",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
