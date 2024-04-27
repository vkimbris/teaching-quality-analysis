from typing import List, Dict


class Classifier:

    def __init__(self, model_path: str) -> None:
        pass

    def predict(self, texts: List[str]) -> List[List[Dict[str, float]]]:
        outputs = []

        for _ in range(len(texts)):
            outputs.append([
                {"name": "class_1", "score": 0.8},
                {"name": "class_2", "score": 0.1},
                {"name": "class_3", "score": 0.1}
            ])
        
        return outputs