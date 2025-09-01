import { Score } from '../model/Score';
import QuizScreen from './QuizScreen';
import { ScoreScreen } from './ScoreScreen';
import SpinTheWheelsScreen from './SpinTheWheelsScreen';

@Entry
@Component
struct Index {

  @Provide('pages') pages: NavPathStack = new NavPathStack();
  @Provide('totalXp') totalXp: number = 0;
  @Provide('scoreInfo') scoreInfo: Score = {
    score: 0,
    percent: 0,
  };

  @Builder PagesMap(name: string) {
    if (name === 'SpinTheWheelsScreen') {
      SpinTheWheelsScreen()
    } else if (name === 'QuizScreen') {
      QuizScreen()
    } else if(name ==='ScoreScreen'){
      ScoreScreen()
    }
  }

  aboutToAppear(): void {
    if (this.pages === undefined) {
      this.pages = new NavPathStack();
    }

    this.pages.pushPathByName('SpinTheWheelsScreen',0)

  }

  build() {
    Navigation(this.pages){}
    .hideTitleBar(true)
    .hideToolBar(true)
    .hideNavBar(true)
    .mode(NavigationMode.Stack)
    .navDestination(this.PagesMap)
  }
}