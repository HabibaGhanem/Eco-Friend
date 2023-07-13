class Tips {
  final String name;
  String details;
  String image;
  Tips({

    required this.name,
    required this.details,
    required this.image

  });
}
final Tips_list=[
  Tips(name:'Choose to take the stairs',details: 'Use the stairs as often as possible. Elevators consume electricity',image: 'assets/stairs2.jpg'),
  Tips(name:'Turn off the lights',details: 'Turn off the lights when natural light is sufficient and when you leave the room. Replace incandescent light bulbs with compact flourescent or LED ones.',image: 'assets/images.jpg'),
  Tips(name:'Reduce food waste',details: 'Make sure to buy what you need or cook only the amount you eat',image: 'assets/reducefoodwaste.jpg'),
  Tips(name:'Talk About climate change',details: 'Start conversation about climate change & steps to take',image: 'assets/talk.jpg'),
  Tips(name:'Listen to a climate podcast',details: 'this is some Podcasts that can raise your awareness about climate change :\n For What It’s Earth \n How to save the planet \n The Climate Question',image: 'assets/podcast.png'),
  Tips(name:'Fly less',details: 'Sometimes it’s OK to ground yourself. make a commitment to cut down on regular flying by staying local, making a video call instead, or finding a new way to explore the world.',image: 'assets/flyless.jpg'),
  Tips(name:'Grow more trees',details: 'Carbon fuels climate change. Trees chew up carbon. Help the experts’ plant, protect & restore our forests. Try to plant a tree in a suitable place around your house',image: 'assets/growtree.png'),
  Tips(name:'Phantom Power',details: 'Did you know that many electronics continue using energy even when powered down? This is true of any charger, television, printer, etc. Unplug it completely when not in use',image: 'assets/unplug.jpg'),
  Tips(name:'Give her a rest',details: 'Turn off the computer when you are away. A computer that is turned off uses 65% less power than a computer that is in sleep mode',image: 'assets/unplugcomp.png'),
  Tips(name:'Shorter Showers',details: 'Try to take shorter showers. The less hot water you use, the less energy is needed to heat the water',image: 'assets/shortshower.png'),


];

class Recommendation {
  final String name;
  String image;
  Recommendation({
    required this.name,
    required this.image

  });
}

final recoList = [];

void add(String habit, double value, String recommendationName) {
  if (!recoList.any((element) => element.name == recommendationName)) {
    if (habit == 'meat' && value > 2) {
      recoList.add(
          Recommendation(name: recommendationName, image: "assets/th.jpg"));
    } else if (habit == 'gas' && value > 2.75) {
      recoList.add(
          Recommendation(name: recommendationName, image: "assets/OIP.jpg"));
    } else if (habit == 'car' && value >= 322) {
      recoList.add(Recommendation(
          name: recommendationName, image: "assets/carpool.jpg"));
    }
    else if (habit == 'short flight' && value > 4) {
      recoList.add(Recommendation(
          name: recommendationName, image: "assets/flyless.jpg"));
    }
    else if (habit == 'long flight' && value > 2) {
      recoList.add(
          Recommendation(name: recommendationName, image: "assets/flight.jpg"));
    }
    else if (habit == 'transit rail' && value > 48) {
      recoList.add(Recommendation(
          name: recommendationName, image: "assets/transit rail.jpg"));
    }
    else if (habit == 'inter city rail' && value > 1609) {
      recoList.add(Recommendation(
          name: recommendationName, image: "assets/inter city rail.jpg"));
    }

    else if (habit == 'Supplies' && value > 23) {
      recoList.add(Recommendation(
          name: recommendationName, image: "assets/Supplies.jpg"));
    }
    else if (habit == 'services' && value > 2475) {
      recoList.add(Recommendation(
          name: recommendationName, image: "assets/services.jpg"));
    }
    else if (habit == 'chicken, seafood, or eggs' && value > 7) {
      recoList.add(Recommendation(
          name: recommendationName, image: "assets/vegetables.jpg"));
    }
    else if (habit == 'living space' && value > 36) {
      recoList.add(
          Recommendation(name: recommendationName, image: "assets/house.jpg"));
    }
    else if (habit == 'milk, cheese, or other dairy products' && value > 7) {
      recoList.add(
          Recommendation(name: recommendationName, image: "assets/milk.jpg"));
    }
    else if (habit == 'Spending on furniture and appliances' && value > 375) {
      recoList.add(Recommendation(
          name: recommendationName, image: "assets/furniture.jpg"));
    }
    else if (habit == 'Traveling by bus' && value > 32) {
      recoList.add(
          Recommendation(name: recommendationName, image: "assets/bike.jpg"));
    }
    else if (habit == 'electricity' && value > 29) {
      recoList.add(
          Recommendation(name: recommendationName, image: "assets/unplug.jpg"));
    }
    else if (habit == 'clothes' && value > 400) {
      recoList.add(
          Recommendation(name: recommendationName, image: "assets/stairs.jpg"));
    }
    printRecoList();
  }
}
void remove() {
  recoList.clear();
}

void printRecoList() {
  print(" RecoList");
  for (int i = 0; i < recoList.length; i++) {
    print('${i + 1}. ${recoList[i].name}');
  }

}

