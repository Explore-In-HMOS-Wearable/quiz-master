export interface Question {
  question: string;
  options: Option[];
}

export interface Option {
  value: string;
  image?: Resource;
  isCorrect: boolean;
}
