void main() {
  print(dummyNameList);
  dummyNameList.forEach((element) {
    alphabetList.add(element[0].toUpperCase());
  });
  alphabetList = alphabetList.toSet().toList();
  alphabetList.sort();
  print(alphabetList);

  print(dummyNameList.where((element) => element[0].toUpperCase() == "J").toList());
}

List<String> alphabetList = [];

List<String> dummyNameList = [
  "James",
  "Robert",
  "Michael",
  "John",
  "David",
  "Richard",
  "William",
  "Joseph",
  "jj",
  "Jessica",
  "Sarah",
  "Lisa",
  "Margaret",
  "Mark",
  "Ashley",
  "Dorothy",
  "Anthony",
];