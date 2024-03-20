import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/views/_base/base_contract.dart';

abstract class AchievementsViewContract extends BaseViewContract {
  void onTapAchievement(Achievement achievement);
}

abstract class AchievementsViewModelContract
    extends BaseViewModelContract<AchievementsState, AchievementsViewContract> {
  void onTapAchievement(Achievement achievement);
}

class AchievementsState extends BaseVMState {
  List<Achievement> achievements = [
    Achievement(
      name: 'Code Ninja',
      description: 'Mastered multiple programming languages.',
      icon: 'code_icon.png',
      points: 100,
      date: DateTime.now(),
      id: 'ach_001',
      verified: true,
      company: 'Company A',
    ),
    Achievement(
        name: 'Bug Hunter',
        description: 'Identified and resolved complex bugs.',
        icon: 'bug_icon.png',
        points: 80,
        date: DateTime.now(),
        id: 'ach_002',
        verified: true,
        company: 'Company B'),
    Achievement(
        name: 'Tech Innovator',
        description: 'Introduced innovative solutions to improve efficiency.',
        icon: 'innovation_icon.png',
        points: 120,
        date: DateTime.now(),
        id: 'ach_003',
        verified: true,
        company: 'Company C'),
    Achievement(
        name: 'Open Source Contributor',
        description: 'Contributed code to open-source projects.',
        icon: 'opensource_icon.png',
        points: 150,
        date: DateTime.now(),
        id: 'ach_004',
        verified: true,
        company: 'Company D'),
    Achievement(
        name: 'Data Wizard',
        description: 'Excelled in data analysis and manipulation.',
        icon: 'data_icon.png',
        points: 90,
        date: DateTime.now(),
        id: 'ach_005',
        verified: true,
        company: 'Company E'),
    Achievement(
        name: 'Agile Guru',
        description: 'Mastered Agile methodologies and practices.',
        icon: 'agile_icon.png',
        points: 110,
        date: DateTime.now(),
        id: 'ach_006',
        verified: true,
        company: 'Company F'),
    Achievement(
        name: 'Cybersecurity Defender',
        description: 'Implemented robust cybersecurity measures.',
        icon: 'cybersecurity_icon.png',
        points: 130,
        date: DateTime.now(),
        id: 'ach_007',
        verified: true,
        company: 'Company G'),
    Achievement(
        name: 'Cloud Computing Expert',
        description: 'Demonstrated expertise in cloud computing technologies.',
        icon: 'cloud_icon.png',
        points: 140,
        date: DateTime.now(),
        id: 'ach_008',
        verified: true,
        company: 'Company H'),
    Achievement(
        name: 'Tech Mentor',
        description: 'Guided and mentored junior team members.',
        icon: 'mentor_icon.png',
        points: 100,
        date: DateTime.now(),
        id: 'ach_009',
        verified: true,
        company: 'Company I'),
    Achievement(
        name: 'Continuous Integration Champion',
        description: 'Implemented and managed CI/CD pipelines.',
        icon: 'ci_icon.png',
        points: 120,
        date: DateTime.now(),
        id: 'ach_010',
        verified: true,
        company: 'Company J'),
  ];
}
