export interface QuizStatus {
  id: string;
  topic: string;
  completed: boolean;
}

export interface QuizModel {
  questions: QuizStatus[]
}