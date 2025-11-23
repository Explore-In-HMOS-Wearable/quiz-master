import { Question } from '../model/Question';

export class Questions {
  private unitMap: Map<string, () => []>;

  constructor() {
    this.unitMap = new Map<string, () => []>();

      this.unitMap.set('History', this.historyList.bind(this));
      this.unitMap.set('Science', this.scienceList.bind(this));
      this.unitMap.set('Art', this.artList.bind(this));
      this.unitMap.set('Sports', this.sportList.bind(this));
      this.unitMap.set('Cinema', this.cinemaList.bind(this));
      this.unitMap.set('Music', this.musicList.bind(this));

  }

  getMethodNames(): string[] {
    return Array.from(this.unitMap.keys());
  }

  callMethodByName(methodName: string): Question[] {
    const methodFunc = this.unitMap.get(methodName);
    if (methodFunc) {
      return methodFunc();
    }
    return [];
  }

  historyList(): Question[] {
    const questionList: Question[] = [
      {
        question: 'First Roman emperor?',

        options: [
          {
            value: 'Julius Caesar',
            isCorrect: false
          },
          {
            value: 'Augustus',
            isCorrect: true
          },
          {
            value: 'Nero',
            isCorrect: false
          },
          {
            value: 'Constantine',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Who wrote the Iliad?',

        options: [
          {
            value: 'Plato',
            isCorrect: false
          },
          {
            value: 'Aristotle',
            isCorrect: false
          },
          {
            value: 'Homer',
            isCorrect: true
          },
          {
            value: 'Socrates',
            isCorrect: false
          }
        ]
      },
      {
        question: 'When did WW2 end?',

        options: [
          {
            value: '1942',
            isCorrect: false
          },
          {
            value: '1945',
            isCorrect: true
          },
          {
            value: '1950',
            isCorrect: false
          },
          {
            value: '1939',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Who was Alexander the Great?',

        options: [
          {
            value: 'Roman Emperor',
            isCorrect: false
          },
          {
            value: 'Egyptian Pharaoh',
            isCorrect: false
          },
          {
            value: 'Greek King',
            isCorrect: true
          },
          {
            value: 'Persian King',
            isCorrect: false
          }
        ]
      },
      {
        question: 'What is the Magna Carta?',

        options: [
          {
            value: 'A war treaty',
            isCorrect: false
          },
          {
            value: 'A legal document',
            isCorrect: true
          },
          {
            value: 'A famous painting',
            isCorrect: false
          },
          {
            value: 'A Roman sculpture',
            isCorrect: false
          }
        ]
      },
      {
        question: 'In what year did the Titanic sink?',

        options: [
          {
            value: '1905',
            isCorrect: false
          },
          {
            value: '1912',
            isCorrect: true
          },
          {
            value: '1920',
            isCorrect: false
          },
          {
            value: '1931',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Who discovered America?',

        options: [
          {
            value: 'Ferdinand Magellan',
            isCorrect: false
          },
          {
            value: 'Vasco da Gama',
            isCorrect: false
          },
          {
            value: 'Marco Polo',
            isCorrect: false
          },
          {
            value: 'Christopher Columbus',
            isCorrect: true
          }
        ]
      },
      {
        question: 'French Revolution started?',

        options: [
          {
            value: '1789',
            isCorrect: true
          },
          {
            value: '1800',
            isCorrect: false
          },
          {
            value: '1776',
            isCorrect: false
          },
          {
            value: '1812',
            isCorrect: false
          }
        ]
      }
    ];

    return questionList;
  }

  scienceList(): Question[] {
    const questionList: Question[] = [
      {
        question: 'Water\'s chemical formula?',

        options: [
          {
            value: 'H2O',
            isCorrect: true
          },
          {
            value: 'CO2',
            isCorrect: false
          },
          {
            value: 'NaCl',
            isCorrect: false
          },
          {
            value: 'O2',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Largest planet in solar system?',
        options: [
          {
            value: 'Mars',
            isCorrect: false
          },
          {
            value: 'Jupiter',
            isCorrect: true
          },
          {
            value: 'Earth',
            isCorrect: false
          },
          {
            value: 'Saturn',
            isCorrect: false
          }
        ]
      },
      {
        question: 'What is a proton\'s charge?',
        options: [
          {
            value: 'Neutral',
            isCorrect: false
          },
          {
            value: 'Negative',
            isCorrect: false
          },
          {
            value: 'Positive',
            isCorrect: true
          },
          {
            value: 'Varies',
            isCorrect: false
          }
        ]
      },
      {
        question: 'What makes up DNA?',
        options: [
          {
            value: 'Amino acids',
            isCorrect: false
          },
          {
            value: 'Lipids',
            isCorrect: false
          },
          {
            value: 'Nucleotides',
            isCorrect: true
          },
          {
            value: 'Sugars',
            isCorrect: false
          }
        ]
      },
      {
        question: 'How many bones?',
        options: [
          {
            value: '206',
            isCorrect: true
          },
          {
            value: '300',
            isCorrect: false
          },
          {
            value: '198',
            isCorrect: false
          },
          {
            value: '212',
            isCorrect: false
          }
        ]
      },
      {
        question: 'What is photosynthesis?',
        options: [
          {
            value: 'Digestion',
            isCorrect: false
          },
          {
            value: 'Plant food making',
            isCorrect: true
          },
          {
            value: 'Respiration',
            isCorrect: false
          },
          {
            value: 'Fermentation',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Strongest acid on Earth?',
        options: [
          {
            value: 'Sulfuric acid',
            isCorrect: false
          },
          {
            value: 'Hydrofluoric acid',
            isCorrect: false
          },
          {
            value: 'Fluoroantimonic acid',
            isCorrect: true
          },
          {
            value: 'Nitric acid',
            isCorrect: false
          }
        ]
      },
      {
        question: 'What is the law of inertia?',
        options: [
          {
            value: 'Newton\'s First Law',
            isCorrect: true
          },
          {
            value: 'Newton\'s Second Law',
            isCorrect: false
          },
          {
            value: 'Newton\'s Third Law',
            isCorrect: false
          },
          {
            value: 'Law of gravity',
            isCorrect: false
          }
        ]
      }
    ]

    return questionList;
  }

  artList(): Question[] {
    const questionList: Question[] = [
      {
        question: 'Who painted the Mona Lisa?',
        options: [
          {
            value: 'Vincent van Gogh',
            isCorrect: false
          },
          {
            value: 'Leonardo da Vinci',
            isCorrect: true
          },
          {
            value: 'Pablo Picasso',
            isCorrect: false
          },
          {
            value: 'Michelangelo',
            isCorrect: false
          }
        ]
      },
      {
        question: 'What is Van Gogh\'s famous painting?',
        options: [
          {
            value: 'The Scream',
            isCorrect: false
          },
          {
            value: 'The Starry Night',
            isCorrect: true
          },
          {
            value: 'The Persistence of Memory',
            isCorrect: false
          },
          {
            value: 'Girl with a Pearl Earring',
            isCorrect: false
          }
        ]
      },
      {
        question: 'What style is Picasso known for?',
        options: [
          {
            value: 'Realism',
            isCorrect: false
          },
          {
            value: 'Cubism',
            isCorrect: true
          },
          {
            value: 'Impressionism',
            isCorrect: false
          },
          {
            value: 'Baroque',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Where is the Statue of David?',
        options: [
          {
            value: 'Paris',
            isCorrect: false
          },
          {
            value: 'London',
            isCorrect: false
          },
          {
            value: 'Rome',
            isCorrect: false
          },
          {
            value: 'Florence',
            isCorrect: true
          }
        ]
      },
      {
        question: 'What is Andy Warhol known for?',
        options: [
          {
            value: 'Pop Art',
            isCorrect: true
          },
          {
            value: 'Expressionism',
            isCorrect: false
          },
          {
            value: 'Surrealism',
            isCorrect: false
          },
          {
            value: 'Abstract Art',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Which country is Frida Kahlo from?',
        options: [
          {
            value: 'Spain',
            isCorrect: false
          },
          {
            value: 'Argentina',
            isCorrect: false
          },
          {
            value: 'Mexico',
            isCorrect: true
          },
          {
            value: 'Italy',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Who painted `The Scream`?',
        options: [
          {
            value: 'Gustav Klimt',
            isCorrect: false
          },
          {
            value: 'Edvard Munch',
            isCorrect: true
          },
          {
            value: 'Claude Monet',
            isCorrect: false
          },
          {
            value: 'Pablo Picasso',
            isCorrect: false
          }
        ]
      },
      {
        question: 'What is The Last Supper?',
        options: [
          {
            value: 'A fresco',
            isCorrect: false
          },
          {
            value: 'A mosaic',
            isCorrect: false
          },
          {
            value: 'A sculpture',
            isCorrect: false
          },
          {
            value: 'A mural painting',
            isCorrect: true
          }
        ]
      }
    ]

    return questionList;
  }

  sportList(): Question[] {
    const questionList: Question[] = [
      {
        question: 'Which country invented football?',
        options: [
          {
            value: 'Brazil',
            isCorrect: false
          },
          {
            value: 'England',
            isCorrect: true
          },
          {
            value: 'Germany',
            isCorrect: false
          },
          {
            value: 'Italy',
            isCorrect: false
          }
        ]
      },
      {
        question: 'How many players in a basketball team?', options: [
          {
            value: '6',
            isCorrect: false
          },
          {
            value: '5',
            isCorrect: true
          },
          {
            value: '7',
            isCorrect: false
          },
          {
            value: '11',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Where do Olympics originate?',
        options: [
          {
            value: 'Rome',
            isCorrect: false
          },
          {
            value: 'Athens',
            isCorrect: true
          },
          {
            value: 'London',
            isCorrect: false
          },
          {
            value: 'Berlin',
            isCorrect: false
          }
        ]
      },
      {
        question: 'What is the highest score in darts?',
        options: [
          {
            value: '180',
            isCorrect: true
          },
          {
            value: '150',
            isCorrect: false
          },
          {
            value: '120',
            isCorrect: false
          },
          {
            value: '200',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Who is the fastest man?',
        options: [
          {
            value: 'Carl Lewis',
            isCorrect: false
          },
          {
            value: 'Usain Bolt',
            isCorrect: true
          },
          {
            value: 'Michael Johnson',
            isCorrect: false
          },
          {
            value: 'Tyson Gay',
            isCorrect: false
          }
        ]
      },
      {
        question: 'What is a perfect score in gymnastics?',
        options: [
          {
            value: '9.9',
            isCorrect: false
          },
          {
            value: '10.0',
            isCorrect: true
          },
          {
            value: '9.5',
            isCorrect: false
          },
          {
            value: '10.5',
            isCorrect: false
          }
        ]
      },
      {
        question: 'What sport uses a shuttlecock?',
        options: [
          {
            value: 'Table tennis',
            isCorrect: false
          },
          {
            value: 'Badminton',
            isCorrect: true
          },
          {
            value: 'Tennis',
            isCorrect: false
          },
          {
            value: 'Volleyball',
            isCorrect: false
          }
        ]
      },
      {
        question: 'How many holes in golf?',
        options: [
          {
            value: '9',
            isCorrect: false
          },
          {
            value: '18',
            isCorrect: true
          },
          {
            value: '12',
            isCorrect: false
          },
          {
            value: '24',
            isCorrect: false
          }
        ]
      }
    ]

    return questionList;
  }

  cinemaList(): Question[] {
    const questionList: Question[] = [
      {
        question: 'Who directed `Pulp Fiction`?',
        options: [
          {
            value: 'Steven Spielberg',
            isCorrect: false
          },
          {
            value: 'Quentin Tarantino',
            isCorrect: true
          },
          {
            value: 'Martin Scorsese',
            isCorrect: false
          },
          {
            value: 'Alfred Hitchcock',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Which movie has the line `I\'ll be back`?',
        options: [
          {
            value: 'Terminator',
            isCorrect: true
          },
          {
            value: 'Matrix',
            isCorrect: false
          },
          {
            value: 'Star Wars',
            isCorrect: false
          },
          {
            value: 'Alien',
            isCorrect: false
          }
        ]
      },
      {
        question: 'What is the highest-grossing film?',
        options: [
          {
            value: 'Titanic',
            isCorrect: false
          },
          {
            value: 'Avengers: Endgame',
            isCorrect: false
          },
          {
            value: 'Avatar',
            isCorrect: true
          },
          {
            value: 'Jurassic World',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Who played James Bond first?',
        options: [
          {
            value: 'Roger Moore',
            isCorrect: false
          },
          {
            value: 'Daniel Craig',
            isCorrect: false
          },
          {
            value: 'Sean Connery',
            isCorrect: true
          },
          {
            value: 'Pierce Brosnan',
            isCorrect: false
          }
        ]
      },
      {
        question: 'What is `Citizen Kane` about?',
        options: [
          {
            value: 'A politician',
            isCorrect: false
          },
          {
            value: 'A newspaper magnate',
            isCorrect: true
          },
          {
            value: 'A spy',
            isCorrect: false
          },
          {
            value: 'A musician',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Which film won Best Picture 1994?',
        options: [
          {
            value: 'Forrest Gump',
            isCorrect: true
          },
          {
            value: 'Pulp Fiction',
            isCorrect: false
          },
          {
            value: 'Shawshank Redemption',
            isCorrect: false
          },
          {
            value: 'Schindler\'s List',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Who played Gandalf?',
        options: [
          {
            value: 'Michael Gambon',
            isCorrect: false
          },
          {
            value: 'Ian McKellen',
            isCorrect: true
          },
          {
            value: 'Richard Harris',
            isCorrect: false
          },
          {
            value: 'Christopher Lee',
            isCorrect: false
          }
        ]
      },
      {
        question: 'What city is Gotham?',
        options: [
          {
            value: 'New York',
            isCorrect: true
          },
          {
            value: 'Chicago',
            isCorrect: false
          },
          {
            value: 'Los Angeles',
            isCorrect: false
          },
          {
            value: 'London',
            isCorrect: false
          }
        ]
      }
    ]

    return questionList;
  }

  musicList(): Question[] {
    const questionList: Question[] = [
      {
        question: 'Who is the `King of Pop`?',
        options: [
          {
            value: 'Elvis Presley',
            isCorrect: false
          },
          {
            value: 'Michael Jackson',
            isCorrect: true
          },
          {
            value: 'James Brown',
            isCorrect: false
          },
          {
            value: 'Prince',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Which instrument has 88 keys?',
        options: [
          {
            value: 'Guitar',
            isCorrect: false
          },
          {
            value: 'Violin',
            isCorrect: false
          },
          {
            value: 'Piano',
            isCorrect: true
          },
          {
            value: 'Drums',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Who sang `Bohemian Rhapsody`?',
        options: [
          {
            value: 'The Beatles',
            isCorrect: false
          },
          {
            value: 'Led Zeppelin',
            isCorrect: false
          },
          {
            value: 'Queen',
            isCorrect: true
          },
          {
            value: 'AC/DC',
            isCorrect: false
          }
        ]
      },
      {
        question: 'What genre is Bob Marley?',
        options: [
          {
            value: 'Jazz',
            isCorrect: false
          },
          {
            value: 'Reggae',
            isCorrect: true
          },
          {
            value: 'Rock',
            isCorrect: false
          },
          {
            value: 'Blues',
            isCorrect: false
          }
        ]
      },
      {
        question: 'What is a musical composition for a solo instrument called?',
        options: [
          {
            value: 'Concerto',
            isCorrect: false
          },
          {
            value: 'Sonata',
            isCorrect: true
          },
          {
            value: 'Symphony',
            isCorrect: false
          },
          {
            value: 'Opera',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Who composed `Symphony No. 5`?',
        options: [
          {
            value: 'Mozart',
            isCorrect: false
          },
          {
            value: 'Beethoven',
            isCorrect: true
          },
          {
            value: 'Bach',
            isCorrect: false
          },
          {
            value: 'Chopin',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Who is a famous Jazz musician?',
        options: [
          {
            value: 'Elvis Presley',
            isCorrect: false
          },
          {
            value: 'Louis Armstrong',
            isCorrect: true
          },
          {
            value: 'Johnny Cash',
            isCorrect: false
          },
          {
            value: 'Bob Dylan',
            isCorrect: false
          }
        ]
      },
      {
        question: 'What is a guitar\'s sixth string?',
        options: [
          {
            value: 'E',
            isCorrect: true
          },
          {
            value: 'A',
            isCorrect: false
          },
          {
            value: 'D',
            isCorrect: false
          },
          {
            value: 'G',
            isCorrect: false
          }
        ]
      }
    ]

    return questionList;
  }

}