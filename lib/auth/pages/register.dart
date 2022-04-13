import '/auth/notifiers/notifiers.dart';
import '/utils/utils.dart';
import '/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Register extends ConsumerWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authStateNotifier.notifier);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: smallVP * 2,
              ),
              Container(
                width: buttonFieldWidth,
                alignment: Alignment.centerLeft,
                child: Text(
                  "Register...",
                  style: defaultTextStyle.copyWith(fontSize: bigTextSize),
                ),
              ),
              SizedBox(
                height: smallVP * 2,
              ),
              SizedBox(
                height: buttonFieldHeight,
                width: buttonFieldWidth,
                child: TextFormField(
                  controller: authNotifier.nameController,
                  decoration: const InputDecoration(
                    hintText: "Name (limit 255)",
                  ),
                ),
              ),
              SizedBox(height: smallVP),
              SizedBox(
                height: buttonFieldHeight,
                width: buttonFieldWidth,
                child: TextFormField(
                  controller: authNotifier.emailController,
                  decoration: const InputDecoration(
                    hintText: "Enter our email: abs@xyz.com",
                  ),
                ),
              ),
              SizedBox(
                height: smallVP,
              ),
              SizedBox(
                height: buttonFieldHeight,
                width: buttonFieldWidth,
                child: TextFormField(
                  obscureText: true,
                  controller: authNotifier.passController,
                  decoration: const InputDecoration(
                    hintText: "Enter atleast 6 character long password",
                  ),
                ),
              ),
              SizedBox(
                height: smallVP,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: buttonFieldHeight,
                    width: buttonFieldWidth / 2 - smallHP / 4,
                    child: DropDown<String>(
                      controller: authNotifier.qualController,
                      isMultiSelect: false,
                      list: qualification,
                      title: "Select your highest qualification",
                      initialText: "Qualification",
                      listTile: (e, s) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                e,
                                style: defaultTextStyle,
                              ),
                              trailing: s
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )
                                  : null,
                            ),
                            Divider(
                              height: 1,
                              color: Colors.grey[200],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: buttonFieldHeight,
                    width: buttonFieldWidth / 2 - smallHP / 4,
                    child: DropDown<String>(
                      controller: authNotifier.discController,
                      isMultiSelect: false,
                      list: disciplines,
                      title: "Discipline of your highest qualification",
                      initialText: "Discipline",
                      listTile: (e, s) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                e,
                                style: defaultTextStyle,
                              ),
                              trailing: s
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )
                                  : null,
                            ),
                            Divider(
                              height: 1,
                              color: Colors.grey[200],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: buttonFieldHeight,
                width: buttonFieldWidth,
                child: TextFormField(
                  controller: authNotifier.addressController,
                  decoration: const InputDecoration(
                    hintText: "Enter your address (limit 255)",
                  ),
                ),
              ),
              SizedBox(
                height: smallVP,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: buttonFieldHeight,
                    width: buttonFieldWidth / 2 - smallHP / 4,
                    child: DropDown<String>(
                      controller: authNotifier.genController,
                      isMultiSelect: false,
                      list: const ["Male", "Female"],
                      title: "Gender",
                      initialText: "Gender",
                      listTile: (e, s) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                e,
                                style: defaultTextStyle,
                              ),
                              trailing: s
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )
                                  : null,
                            ),
                            Divider(
                              height: 1,
                              color: Colors.grey[200],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: smallHP,
                  ),
                  SizedBox(
                    height: buttonFieldHeight,
                    width: buttonFieldWidth / 2 - smallHP / 4,
                    child: TextFormField(
                      controller: authNotifier.ageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Age",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: buttonFieldHeight,
                width: buttonFieldWidth,
                child: TextFormField(
                  controller: authNotifier.phoneController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "Enter your phone number",
                  ),
                ),
              ),
              SizedBox(
                height: smallVP,
              ),
              SizedBox(
                height: buttonFieldHeight,
                width: buttonFieldWidth,
                child: DropDown<String>(
                  controller: authNotifier.countryController,
                  isMultiSelect: false,
                  list: countries,
                  title: "Country",
                  initialText: "Select your country",
                  listTile: (e, s) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            e,
                            style: defaultTextStyle,
                          ),
                          trailing: s
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )
                              : null,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey[200],
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: smallVP,
              ),
              GoodButton(
                text: "Register",
                bgColor: Colors.green,
                textColor: Colors.white,
                onTap: () async {
                  final res = await authNotifier.register();
                },
              ),
              SizedBox(
                height: smallVP,
              ),
              GoodButton(
                text: "Go to sign in",
                borderColor: Colors.white,
                textColor: Colors.blue,
                onTap: () {
                  authNotifier.gotoSignIn();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const List<String> disciplines = [
  "Agriculture and related sciences",
  "Natural resources and conservation",
  "Agriculture/natural resources/related",
  "Biochem/biophysics/molecular biology",
  "Botany/plant biology",
  "Genetics",
  "Microbiological sciences & immunology",
  "Physiology, pathology & related sciences",
  "Zoology/animal biology",
  "Biological & biomedical sciences",
  "Computer/info tech administration/mgmt",
  "Computer programming",
  "Computer science",
  "Computer software and media applications",
  "Computer systems analysis",
  "Computer systems networking/telecom",
  "Data entry/microcomputer applications",
  "Data processing",
  "Information science/studies",
  "Computer/info sci/support svcs",
  "Biomedical/medical engineering",
  "Chemical engineering",
  "Civil engineering",
  "Computer engineering",
  "Electrical/electronics/comms engineering",
  "Engineering technologies/technicians",
  "Environmental/environmental health eng",
  "Mechanical engineering",
  "Alternative/complementary medicine/sys",
  "Clinical/medical lab science/allied",
  "Dental support services/allied",
  "Dentistry",
  "Health & medical administrative services",
  "Allied health and medical assisting services",
  "Allied health diagnostic, intervention",
  "Medicine, including psychiatry",
  "Nursing",
  "Optometry",
  "Osteopathic medicine/osteopathy",
  "Pharmacy/pharmaceutical sciences/admin",
  "Podiatric medicine/podiatry",
  "Public health",
  "Veterinary medicine",
  "Health/related clinical services",
  "Mathematics",
  "Statistics",
  "Mathematics and statistics",
  "Astronomy & astrophysics",
  "Atmospheric sciences and meteorology",
  "Chemistry",
  "Geological & earth sciences/geosciences",
  "Physics",
  "Physical sciences",
  "Clinical psychology",
  "Engineering"
];

const List<String> countries = [
  "Afghanistan",
  "Albania",
  "Algeria",
  "Andorra",
  "Angola",
  "Antigua & Deps",
  "Argentina",
  "Armenia",
  "Australia",
  "Austria",
  "Azerbaijan",
  "Bahamas",
  "Bahrain",
  "Bangladesh",
  "Barbados",
  "Belarus",
  "Belgium",
  "Belize",
  "Benin",
  "Bhutan",
  "Bolivia",
  "Bosnia Herzegovina",
  "Botswana",
  "Brazil",
  "Brunei",
  "Bulgaria",
  "Burkina",
  "Burundi",
  "Cambodia",
  "Cameroon",
  "Canada",
  "Cape Verde",
  "Central African Rep",
  "Chad",
  "Chile",
  "China",
  "Colombia",
  "Comoros",
  "Congo",
  "Congo {Democratic Rep}",
  "Costa Rica",
  "Croatia",
  "Cuba",
  "Cyprus",
  "Czech Republic",
  "Denmark",
  "Djibouti",
  "Dominica",
  "Dominican Republic",
  "East Timor",
  "Ecuador",
  "Egypt",
  "El Salvador",
  "Equatorial Guinea",
  "Eritrea",
  "Estonia",
  "Ethiopia",
  "Fiji",
  "Finland",
  "France",
  "Gabon",
  "Gambia",
  "Georgia",
  "Germany",
  "Ghana",
  "Greece",
  "Grenada",
  "Guatemala",
  "Guinea",
  "Guinea-Bissau",
  "Guyana",
  "Haiti",
  "Honduras",
  "Hungary",
  "Iceland",
  "India",
  "Indonesia",
  "Iran",
  "Iraq",
  "Ireland {Republic}",
  "Israel",
  "Italy",
  "Ivory Coast",
  "Jamaica",
  "Japan",
  "Jordan",
  "Kazakhstan",
  "Kenya",
  "Kiribati",
  "Korea North",
  "Korea South",
  "Kosovo",
  "Kuwait",
  "Kyrgyzstan",
  "Laos",
  "Latvia",
  "Lebanon",
  "Lesotho",
  "Liberia",
  "Libya",
  "Liechtenstein",
  "Lithuania",
  "Luxembourg",
  "Macedonia",
  "Madagascar",
  "Malawi",
  "Malaysia",
  "Maldives",
  "Mali",
  "Malta",
  "Marshall Islands",
  "Mauritania",
  "Mauritius",
  "Mexico",
  "Micronesia",
  "Moldova",
  "Monaco",
  "Mongolia",
  "Montenegro",
  "Morocco",
  "Mozambique",
  "Myanmar, {Burma}",
  "Namibia",
  "Nauru",
  "Nepal",
  "Netherlands",
  "New Zealand",
  "Nicaragua",
  "Niger",
  "Nigeria",
  "Norway",
  "Oman",
  "Pakistan",
  "Palau",
  "Panama",
  "Papua New Guinea",
  "Paraguay",
  "Peru",
  "Philippines",
  "Poland",
  "Portugal",
  "Qatar",
  "Romania",
  "Russian Federation",
  "Rwanda",
  "St Kitts & Nevis",
  "St Lucia",
  "Saint Vincent & the Grenadines",
  "Samoa",
  "San Marino",
  "Sao Tome & Principe",
  "Saudi Arabia",
  "Senegal",
  "Serbia",
  "Seychelles",
  "Sierra Leone",
  "Singapore",
  "Slovakia",
  "Slovenia",
  "Solomon Islands",
  "Somalia",
  "South Africa",
  "South Sudan",
  "Spain",
  "Sri Lanka",
  "Sudan",
  "Suriname",
  "Swaziland",
  "Sweden",
  "Switzerland",
  "Syria",
  "Taiwan",
  "Tajikistan",
  "Tanzania",
  "Thailand",
  "Togo",
  "Tonga",
  "Trinidad & Tobago",
  "Tunisia",
  "Turkey",
  "Turkmenistan",
  "Tuvalu",
  "Uganda",
  "Ukraine",
  "United Arab Emirates",
  "United Kingdom",
  "United States",
  "Uruguay",
  "Uzbekistan",
  "Vanuatu",
  "Vatican City",
  "Venezuela",
  "Vietnam",
  "Yemen",
  "Zambia",
  "Zimbabwe",
];

const List<String> qualification = [
  "Class10",
  "Class12",
  "Bachelors",
  "Masters",
  "PhD",
  "PostDoc",
];
