
import { media } from '@kit.MediaKit';
import { common } from '@kit.AbilityKit';
import { audio } from '@kit.AudioKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { Question } from '../model/Question';
import { Score } from '../model/Score';
import { Questions } from '../viewmodel/Questions';
import { DataManager } from '../utils/QuizData';
import { TextQuestion } from '../components/TextQuestion';
import { CustomButton } from '../components/CustomButton';

const PROGRESS_TOTAL = 100;
const XP = 35;

@Component
export default struct QuizScreen {

  @Consume('pages') pages: NavPathStack;
  @Consume('scoreInfo') scoreInfo: Score;

  @State questionList: Question[] = [];
  @State currentQuestionIndex: number = 0;
  @State selectedIndex: number = -1;
  @State progressValue: number = 10;
  @State isShowCheckQuestionDialog: boolean = false;
  @State answerState: boolean = false;
  @State totalTime: number = 0;
  @State correctCount: number = 0;
  @State totalPoint: number = 0;
  @State currentQuestion: Question = {
    question: '',
    options: [],
  };
  private avPlayer?: media.AVPlayer;
  private timer: number = 0;
  private questions = new Questions();
  scroller: Scroller = new Scroller()
  private dataManager = DataManager.getInstance()


  @State timeLeft: number = 10;
  @State timerId: number = -1;
  @State message:string = ''
  @State topic:string = ''

  startTimer(): void {
    this.clearTimer();
    this.timeLeft = 10;
    this.timerId = setInterval(() => {
      this.timeLeft--;
      if (this.timeLeft <= 0) {
        this.timeUp();
      }
    }, 1000);
  }


  timeUp(): void {
    this.clearTimerLast();
    this.message=  'You didn`t answer in time.' ;
    AlertDialog.show(
      {
        title: 'Time Up!',
        message: this.message,
        autoCancel: true,
        alignment: DialogAlignment.Center,
        gridCount: 3,
        width: '99%',
        height: '99%',
        cornerRadius: 200,
        borderWidth: 1,
        borderStyle: BorderStyle.Solid,
        borderColor: Color.Red,
        backgroundBlurStyle:BlurStyle.NONE,
        backgroundColor: '#ffa2a2a2',
        textStyle: { wordBreak: WordBreak.BREAK_ALL },
        confirm: {
          value: 'Try Again',
          fontColor:Color.Red,
          action: () => {
            this.pages.pushPathByName('SpinTheWheelsScreen',0)
          }
        }
      }
    )
  }


  clearTimerLast(): void {
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
      this.timerId = -1;
    }
  }

  setAVPlayerCallback(avPlayer: media.AVPlayer) {

    avPlayer.on('error', (err: BusinessError) => {
      avPlayer.reset();
    });

    avPlayer.on('stateChange', async (state: string, reason: media.StateChangeReason) => {
      switch (state) {
        case 'idle':
          avPlayer.release();
          break;
        case 'initialized':
          avPlayer.audioRendererInfo = {
            usage: audio.StreamUsage.STREAM_USAGE_MUSIC,
            rendererFlags: 0
          };
          avPlayer.prepare();
          break;
        case 'prepared':
          avPlayer.play();
          break;
        case 'playing':
          break;
        case 'paused':
          break;
        case 'completed':
          avPlayer.stop();
          break;
        case 'stopped':
          avPlayer.reset();
          break;
        case 'released':
          break;
        default:
          break;
      }
    });
  }

  async correctAnswer() {
    this.clearTimerLast();

    this.correctCount++;
    this.avPlayer = await media.createAVPlayer();
    this.setAVPlayerCallback(this.avPlayer);
    const context = this.getUIContext().getHostContext() as Context;
    const file = await context.resourceManager.getRawFd('correct_answer.mp3');
    const avFileDesc: media.AVFileDescriptor = {
      fd: file.fd, offset: file.offset, length: file.length
    }
    if (this.avPlayer) {
      this.avPlayer.fdSrc = avFileDesc;
      this.avPlayer.play();
    }
  }

  async wrongAnswer() {
    this.clearTimerLast();

    this.avPlayer = await media.createAVPlayer();
    this.setAVPlayerCallback(this.avPlayer);
    const context = this.getUIContext().getHostContext() as Context
    const file = await context.resourceManager.getRawFd('wrong_answer.mp3');
    const avFileDesc: media.AVFileDescriptor = {
      fd: file.fd, offset: file.offset, length: file.length
    }
    if (this.avPlayer) {
      this.avPlayer.fdSrc = avFileDesc;
      this.avPlayer.play();
    }
  }

  async quizComplete() {
    this.dataManager.completeTopicLesson(this.topic)
    this.clearTimer();
    this.calcScore();
    this.pages.pop();
    this.avPlayer = await media.createAVPlayer();
    this.setAVPlayerCallback(this.avPlayer);
    const context = this.getUIContext().getHostContext() as Context
    const file = await context.resourceManager.getRawFd('quiz_complete.mp3');
    const avFileDesc: media.AVFileDescriptor = {
      fd: file.fd, offset: file.offset, length: file.length
    }
    if (this.avPlayer) {
      this.avPlayer.fdSrc = avFileDesc;
      this.avPlayer.play();
    }
  }

  calcScore() {
    const score: Score = {
      score: this.correctCount * XP,
      percent: Math.round(PROGRESS_TOTAL / this.questionList.length * this.correctCount),
    }
    this.scoreInfo = score;
  }

  async aboutToAppear(): Promise<void> {

   this.topic =  AppStorage.get('selectedTopic') as string

    this.questions = new Questions();
    this.questionList = this.questions.callMethodByName(this.topic);
    this.currentQuestion = this.questionList[this.currentQuestionIndex];
    this.initTimer();
    this.startTimer();
  }

  aboutToDisappear(): void {
    this.clearTimer();
    this.clearTimerLast();

  }

  initTimer() {
    this.timer = setInterval(() => {
      this.totalTime++;
    }, 1000)
  }

  clearTimer() {
    clearInterval(this.timer);
  }

  nextQuestion() {
    this.currentQuestionIndex++;
    this.selectedIndex = -1;
    this.currentQuestion = this.questionList[this.currentQuestionIndex];
    this.scroller.scrollEdge(Edge.Top)
    this.startTimer()
  }

  @Builder
  QuestionCheck() {
    Column({ space: 8 }) {
      Column({ space: 8 }) {
        Row({ space: 4 }) {
          Image(this.answerState === true ? $r('app.media.correct') : $r('app.media.incorrect'))
            .width(18)
            .height(18);

          Text(this.answerState === true ? 'Excellent!' : 'Incorrect!')
            .fontSize(18)
            .fontColor(this.answerState === true ? '#58CC02' : '#FF4B4B')
            .fontWeight(FontWeight.Bold);
        }
        .width('100%')
        .justifyContent(FlexAlign.Center);

        if (this.answerState === false) {
          Column() {
            Text(`${this.currentQuestion.options.filter((answer) => answer.isCorrect)[0].value}`)
              .fontColor('#58CC02')
              .fontSize(18)
              .textAlign(TextAlign.Center)
              .fontWeight(FontWeight.Bold);
          }.alignItems(HorizontalAlign.Center)
        }
        Row() {
          CustomButton({
            text: 'Continue',
            isEnabled: true,
            type: this.answerState,
            onAction: () => {
              if (this.currentQuestionIndex >= this.questionList.length - 1) {
                this.isShowCheckQuestionDialog = false;
                this.quizComplete();
                this.pages.pushPathByName('ScoreScreen', '')
                return;
              }
              this.isShowCheckQuestionDialog = false;
              this.nextQuestion();

            }
          }).width('50%')
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
      }
      .width('100%')
      .height(60)
      .padding(12)
    }
    .backgroundColor(this.answerState === true ? '#D6FFB8' : '#FFDFE0')
    .height('100%')
    .padding(12)
  }

  build() {
    NavDestination() {
      Row({ space: 6 }) {
        Text(`${this.timeLeft}s`)
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.timeLeft <= 3 ? '#FF4444' : '#FF6B35')
          .padding(3)
          .borderRadius(1)
      }
      .alignItems(VerticalAlign.Center)
      .width(60)
      .borderRadius(15)
      .backgroundColor(this.timeLeft <= 3 ? '#ffebee' : '#fff3e0')
      .justifyContent(FlexAlign.Center);

      Scroll(this.scroller) {
        Column({ space: 6 }) {
          Text(this.currentQuestion.question)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black);

            TextQuestion({
              currentQuestion: this.currentQuestion,
              selectedIndex: this.selectedIndex
            })


          CustomButton({
            text: 'Check',
            isEnabled: this.selectedIndex > -1,
            type: true,
            onAction: () => {
              this.isShowCheckQuestionDialog = true;
              this.progressValue =
                PROGRESS_TOTAL / (this.questionList.length) * (this.currentQuestionIndex + 1)

              if (this.currentQuestion.options[this.selectedIndex].isCorrect) {
                this.answerState = true;
                this.correctAnswer();
              } else {
                this.answerState = false;
                this.wrongAnswer();
              }
            }
          }).width('50%')
        }
        .padding({
          bottom: 24
        })
        .width('100%');
      }
      .scrollBar(BarState.Off)
      .padding({
        bottom: 12,
        top: 12
      })
      .height('100%')
      .bindSheet(this.isShowCheckQuestionDialog, this.QuestionCheck(), {
        height: 150,
        mode: SheetMode.OVERLAY,
        showClose: false,
        onWillDismiss: (() => {
          return false;
        })
      })

    }
    .backgroundColor(Color.White)
    .padding(12)
    .hideTitleBar(true);

  }
}