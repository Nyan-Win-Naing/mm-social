import 'package:flutter/material.dart';
import 'package:mm_social/blocs/contact_bloc.dart';
import 'package:mm_social/data/vos/user_vo.dart';
import 'package:mm_social/dummy/dummy_data.dart';
import 'package:mm_social/resources/colors.dart';
import 'package:mm_social/resources/dimens.dart';
import 'package:mm_social/viewitems/contact_view.dart';
import 'package:provider/provider.dart';

class ContactPage extends StatefulWidget {
  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContactBloc(),
      child: Scaffold(
        backgroundColor: SECONDARY_COLOR,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: PRIMARY_COLOR,
          centerTitle: true,
          elevation: 2.0,
          title: Text(
            "Contacts",
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: MARGIN_MEDIUM_2),
              child: Icon(
                Icons.person_add,
              ),
            ),
          ],
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MARGIN_MEDIUM_2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                  child: SearchContactFormSectionView(),
                ),
                SizedBox(height: MARGIN_MEDIUM_2),
                Selector<ContactBloc, List<UserVO>>(
                  selector: (context, bloc) => bloc.contactList ?? [],
                  builder: (context, contactList, child) => Selector<ContactBloc, List<String>>(
                    selector: (context, bloc) => bloc.alphabetList ?? [],
                    builder: (context, alphabetList, child) => ListView.builder(
                      itemCount: alphabetList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ContactGroupedByAlphabetView(alphabet: alphabetList[index], contactList: contactList);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchContactFormSectionView extends StatelessWidget {
  const SearchContactFormSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          fillColor: Colors.grey,
          filled: true,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
              horizontal: MARGIN_MEDIUM, vertical: MARGIN_MEDIUM),
          hintText: "Search",
          hintStyle: TextStyle(
            color: SECONDARY_COLOR,
            fontSize: TEXT_REGULAR,
          )),
    );
  }
}
