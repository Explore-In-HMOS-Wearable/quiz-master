import { Option, Question } from '../model/Question';

@Component
export struct TextQuestion {
  @Prop currentQuestion: Question;
  @Link selectedIndex: number;

  build() {
    Column({ space: 12 }){
      ForEach(this.currentQuestion.options, (item: Option, index) => {
        Button(item.value).onClick(() => {
          this.selectedIndex = index;
        })
          .fontColor(this.selectedIndex === index ? Color.White : Color.Black)
          .backgroundColor(Color.White)
          .borderWidth(2)
          .type(ButtonType.Normal)
          .borderRadius(12)
          .borderColor(this.selectedIndex === index ? '#1899D6' : '#777777')
          .width(150)
          .clickEffect({
            level: ClickEffectLevel.HEAVY
          })
          .backgroundColor(this.selectedIndex === index ? '#63C9F9' : Color.White);

      })
    }

  }
}