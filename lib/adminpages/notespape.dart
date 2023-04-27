import 'package:clg_project/screens/views/notes.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import '../models/subject.dart';
import '../models/subject.dart';
import '../reuableWidget/subjectWidget.dart';

class NotesPage extends StatefulWidget {
  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  //List<Subject> subjectList=[];
  final String assetName = 'assets/YIt_2.svg';
  final List<Subject> subjectData = [
    Subject(
        id: 1,
        imageUrl:
            'https://cdn.pixabay.com/photo/2016/04/13/16/09/pi-1327145__340.png',
        subjectCode: '18MAT31',
        scheme: '2018',
        subjectName: 'M3'),
    Subject(
        id: 2,
        imageUrl:
            'https://cdn.pixabay.com/photo/2018/07/14/11/33/earth-3537401__340.jpg',
        subjectCode: '18EC32',
        scheme: '2018',
        subjectName: 'Network Theory'),
    Subject(
        id: 3,
        imageUrl:
            'https://cdn.pixabay.com/photo/2014/09/20/13/52/board-453758__340.jpg',
        subjectCode: '18EC33',
        scheme: '2018',
        subjectName: 'Electronics Devices'),
    Subject(
        id: 4,
        imageUrl:
            'https://cdn.pixabay.com/photo/2014/09/20/13/52/board-453758__340.jpg',
        subjectCode: '18EC34',
        scheme: '2018',
        subjectName: 'Digital System Design'),
    Subject(
        id: 5,
        imageUrl:
            'https://cdn.pixabay.com/photo/2016/04/04/14/12/monitor-1307227_960_720.jpg',
        subjectCode: '18EC35',
        scheme: '2018',
        subjectName: 'COA'),
    Subject(
        id: 6,
        imageUrl:
            'https://cdn.pixabay.com/photo/2015/09/09/22/05/cooler-933691_960_720.jpg',
        subjectCode: '18EC36',
        scheme: '2018',
        subjectName: 'Power Electr..')
  ];
/////////-------------4th sem
  final List<Subject> fourthNotes = [
    Subject(
        id: 1,
        imageUrl:
            'https://cdn.pixabay.com/photo/2016/04/13/16/09/pi-1327145__340.png',
        subjectCode: '18MAT41',
        scheme: '2018',
        subjectName: 'M4'),
    Subject(
        id: 2,
        imageUrl:
            'https://cdn.pixabay.com/photo/2015/08/10/21/13/stereo-883186__340.jpg',
        subjectCode: '18EC42',
        scheme: '2018',
        subjectName: 'Analog Circuitss'),
    Subject(
        id: 3,
        imageUrl:
            'https://cdn.pixabay.com/photo/2019/05/12/11/04/mixer-4197733__340.jpg',
        subjectCode: '18EC43',
        scheme: '2018',
        subjectName: 'Control Systems'),
    Subject(
        id: 4,
        imageUrl:
            'https://cdn.pixabay.com/photo/2017/05/14/03/45/data-2311261__340.png',
        subjectCode: '18EC44',
        scheme: '2018',
        subjectName: 'Engineering ...'),
    Subject(
        id: 5,
        imageUrl:
            'https://cdn.pixabay.com/photo/2015/12/12/20/48/antennas-1090084__340.jpg',
        subjectCode: '18EC45',
        scheme: '2018',
        subjectName: 'Signals & .'),
    Subject(
        id: 6,
        imageUrl:
            'https://cdn.pixabay.com/photo/2016/09/28/08/48/iduino-uno-r3b-1699990__340.png',
        subjectCode: '18EC46',
        scheme: '2018',
        subjectName: 'Microcontroller')
  ];

  @override
  Widget build(BuildContext context) {
    // final loadedSubjectData =
    //     Provider.of<SubjectsProvider>(context, listen: false).subjectsData;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ChangeNotifierProvider(
              //   create: (context) => SubjectsProvider(),
              //   child: SubjectWidget(),
              // )
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '3rd sem Notes',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: subjectData.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (ctx) => NotesView(
                                    text: subjectData[index]
                                        .subjectName
                                        .toString()))),
                        child: SubjectWidget(
                          id: subjectData[index].id,
                          subjectName: subjectData[index].subjectName,
                          subjectCode: subjectData[index].subjectCode,
                          imageUrl: subjectData[index].imageUrl,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '4th sem Notes',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: fourthNotes.length,
                      itemBuilder: (context, index) => SubjectWidget(
                        id: fourthNotes[index].id,
                        subjectName: fourthNotes[index].subjectName,
                        subjectCode: fourthNotes[index].subjectCode,
                        imageUrl: fourthNotes[index].imageUrl,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
