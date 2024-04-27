from typing import List
from llama_cpp import Llama


class Explainer:
    generation_kwargs = {
        "max_tokens": 500,  # Max number of new tokens to generate
        "stop": ["<eos>"],  # Text sequences to stop generation on
        "echo": False,  # Echo the prompt in the output
        "top_k": 1
    }

    model_kwargs = {
        "n_ctx": 4096,  # Context length to use
        "n_threads": 4,  # Number of CPU threads to use
        "n_gpu_layers": 0,  # Number of model layers to offload to GPU. Set to 0 if only using CPU
    }

    llama_prompt = """
    ### Input:
    {}

    ### Response:
    {}"""

    def __init__(self, repo_id: str, model_file_name: str) -> None:
        self.llm = Llama.from_pretrained(
            repo_id=repo_id,
            filename=model_file_name,
            verbose=True,
            model_type="llama"
        )

    @staticmethod
    def __create_text_message(messages: List[str]) -> str:
        """
        Concatenates text messages in string-list

        :param messages: list of string messages
        :return: str concatenated messages string
        """
        message_text = ""
        for message in messages:
            message_text += f"- {message}\n"

        return message_text

    def predict(self, messages: List[str]) -> str:
        messages_text = self.__create_text_message(messages)
        prompt = self.llama_prompt.format(messages_text, '')
        summary = self.llm(prompt, **self.generation_kwargs)
        return summary["choices"][0]['text']
