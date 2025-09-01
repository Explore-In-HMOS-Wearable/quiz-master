import { QuizModel } from '../model/QuizStatus';

const STORAGE_KEY = 'lessons';

export class DataManager {
  private static instance: DataManager;
  private data: QuizModel = {
    questions: []
  }

  private constructor() {
    this.loadData();
  }

  public static getInstance(): DataManager {
    if (!DataManager.instance) {
      DataManager.instance = new DataManager();
    }
    return DataManager.instance;
  }

  private async loadData() {
    try {
      const storedData = AppStorage.get<QuizModel>(STORAGE_KEY);
      if (storedData?.questions && storedData.questions.length > 0) {
        this.data = storedData;
      } else {
        await this.saveData();
      }
    } catch (error) {
    }
  }


  private async saveData() {
    try {
      AppStorage.set(STORAGE_KEY, this.data);
    } catch (error) {
    }
  }

  public async completeTopicLesson(topic: string) {
    const id = `${topic}`;
    const topicIndex = this.data.questions.findIndex(t => t.id === id);

    if (topicIndex !== -1) {
      this.data.questions[topicIndex].completed = true;
      await this.saveData();
    }
  }
}