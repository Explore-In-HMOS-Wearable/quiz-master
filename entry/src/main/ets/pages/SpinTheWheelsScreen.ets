import {
  JArrayList,
  MPPointF,
  PieChart,
  PieChartModel,
  PieData,
  PieDataSet,
  PieEntry
} from '@ohos/mpchart';
import animator, { AnimatorOptions, AnimatorResult } from '@ohos.animator';
import {
  ArcButton,
  ArcButtonOptions, ArcButtonPosition, ArcButtonStatus, ArcButtonStyleMode, LengthMetrics,LengthUnit } from '@kit.ArkUI';

@Component
export default struct SpinTheWheelsScreen {
  @Consume('pages') pages: NavPathStack;
  bottomOptions: ArcButtonOptions = new ArcButtonOptions({});
  topOptions: ArcButtonOptions = new ArcButtonOptions({});


  model: PieChartModel = new PieChartModel();
  private animatorResult: AnimatorResult | null = null
  @State chooseText: string = 'Spin';
  @State onePartAngle: number = 0;
  @State count: number = 6;
  @State currentIndex: number = 0;
  parties: string[] = ['History', 'Science', 'Art', 'Sports', 'Cinema', 'Music'];
  @State isSpinning:boolean = true;
  @State topic:string = ''
  @State selectedTopic:string = ''


  setTopic(topic: string){
    switch (topic)
    {
      case 'History':
        this.selectedTopic = 'History'
        break
      case 'Science':
        this.selectedTopic = 'Science'
        break
      case 'Art':
        this.selectedTopic = 'Art'
        break
      case 'Sports':
        this.selectedTopic = 'Sports'
        break
      case 'Cinema':
        this.selectedTopic = 'Cinema'
        break
      case 'Music':
        this.selectedTopic = 'Music'
        break
    }
    AppStorage.setOrCreate('selectedTopic', this.selectedTopic);

  }

  aboutToAppear(): void {

    this.bottomOptions = new ArcButtonOptions({
      label: 'Start',
      status: ArcButtonStatus.NORMAL,
      styleMode: ArcButtonStyleMode.EMPHASIZED_LIGHT,
      position: ArcButtonPosition.BOTTOM_EDGE,
      fontSize: new LengthMetrics(15, LengthUnit.FP),
      shadowEnabled: true,
      onClick: () => {
        this.pages.pushPathByName('QuizScreen',0)
      }
    })


    this.init();
  }

  build() {
    NavDestination(){
      Column() {
        Stack(){
          Stack() {
            PieChart({ model: this.model })
              .width('99%')
              .aspectRatio(1)
            Text('▼')
              .fontSize(26)
              .fontWeight(FontWeight.Bolder)
              .alignSelf(ItemAlign.Start)
              .height('100%')
              .textAlign(TextAlign.Start)
              .align(Alignment.Top)
              .margin({ top: -15 })


            Button(){
              Text(this.chooseText).fontWeight(FontWeight.Bold)
            }
            .onClick(() => {
              this.startGun();
            })
            .alignSelf(ItemAlign.Center)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
            .width(75)
            .height(75)
            .borderRadius(200)
            .backgroundColor('#2071ff')
            .align(Alignment.Center)
            .shadow({
              offsetX: 1,
              offsetY: 1,
              color: Color.Black,
              radius: 10
            })


          }.height('100%')

          if (!this.isSpinning){
            ArcButton({ options: this.bottomOptions }).align(Alignment.Bottom)
          }


        }.align(Alignment.Bottom)

      }
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .height('100%')
      .backgroundColor(Color.Black)
    }
  .hideTitleBar(true);

  }

  init() {
    this.model.getDescription()?.setEnabled(false);
    this.model.setDrawHoleEnabled(false);
    this.model.getLegend()?.setEnabled(false);
    this.model.disableScroll();
    this.model.setRotationEnabled(true);
    this.model.setHighlightPerTapEnabled(true);
    this.model.setEntryLabelTextSize(14)
    this.model.setEntryLabelColor(Color.White)
    this.model.setTouchEnabled(false);
    this.setData(5);
  }

  private async setData(range: number): Promise<void> {
    let entries: JArrayList<PieEntry> = new JArrayList<PieEntry>();
    for (let i = 0; i < this.count; i++) {
      entries.add(new PieEntry(range,
        this.parties[i % this.parties.length]));
    }
    let dataSet: PieDataSet = new PieDataSet(entries, "Election Results");
    dataSet.setSliceSpace(1);
    dataSet.setIconsOffset(new MPPointF(0, 40));
    dataSet.setSelectionShift(0);
    dataSet.setValueTextColor(Color.White);
    dataSet.setDrawValues(false);

    const customColors: number[] = [
      0x9066bd,
      0xB572CA,
      0xee66bb,
      0xf4777c,
      0xF7AC7C,
      0xFAC166
    ];

    let colors: JArrayList<number> = new JArrayList();
    for (let color of customColors) {
      colors.add(color);
    }

    dataSet.setColorsByList(colors);
    let data: PieData = new PieData(dataSet);
    this.onePartAngle = 360 / this.count;
    this.model.setRotationAngle(-90 - this.onePartAngle / 2);
    this.model.setData(data);
  }

  startGun() {
    this.isSpinning = true
    let currentAngle = this.model.getRotationAngle();
    let randomRotation = Math.floor(Math.random() * 360);
    let end = 7200 + currentAngle + randomRotation;

    let options: AnimatorOptions = {
      duration: 11000,
      easing: "ease",
      delay: 0,
      fill: "forwards",
      direction: "normal",
      begin: currentAngle,
      end: end,
      iterations: 1
    };

    this.animatorResult = animator.create(options);
    this.animatorResult.onframe = (value) => {
      this.model.setRotationAngle(value);
      this.model.invalidate();
    };

    this.animatorResult.onfinish = () => {
      let finalRotation = end % 360;

      let adjustedAngle = finalRotation + 90;
      if (adjustedAngle > 360) {
        adjustedAngle -= 360;
      }

      let index = Math.floor(adjustedAngle / this.onePartAngle);
      this.currentIndex = (this.count - 1) - index;

      this.chooseText = this.parties[this.currentIndex];

      this.setTopic(this.chooseText)

      this.isSpinning = false
    };

    this.animatorResult.play();
  }
}