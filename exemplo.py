#!/usr/bin/env python3
"""
Arquivo de teste para plugins do Neovim
Testa: LSP, Treesitter, Formatação, Linting, etc.
"""

import json
import sys
from dataclasses import dataclass
from enum import Enum
from typing import Dict, List, Optional, Union


class Color(Enum):
    """Enumeração para cores"""

    RED = "red"
    GREEN = "green"
    BLUE = "blue"


@dataclass
class Person:
    """Classe de exemplo usando dataclass"""

    name: str
    age: int
    email: Optional[str] = None

    def greet(self) -> str:
        """Método que retorna uma saudação"""
        return f"Olá, meu nome é {self.name} e tenho {self.age} anos!"


class Calculator:
    """Classe de calculadora para demonstrar métodos"""

    def __init__(self):
        self.history: List[str] = []

    def add(self, a: float, b: float) -> float:
        """Soma dois números"""
        result = a + b
        self.history.append(f"{a} + {b} = {result}")
        return result

    def subtract(self, a: float, b: float) -> float:
        """Subtrai dois números"""
        result = a - b
        self.history.append(f"{a} - {b} = {result}")
        return result

    def multiply(self, a: float, b: float) -> float:
        """Multiplica dois números"""
        result = a * b
        self.history.append(f"{a} * {b} = {result}")
        return result

    def divide(self, a: float, b: float) -> float:
        """Divide dois números (tratamento de erro)"""
        if b == 0:
            raise ValueError("Não é possível dividir por zero!")
        result = a / b
        self.history.append(f"{a} / {b} = {result}")
        return result

    def get_history(self) -> List[str]:
        """Retorna o histórico de operações"""
        return self.history


def fibonacci(n: int) -> List[int]:
    """
    Gera sequência de Fibonacci até n elementos.

    Args:
        n: Número de elementos na sequência

    Returns:
        Lista com sequência de Fibonacci

    Raises:
        ValueError: Se n for negativo
    """
    if n < 0:
        raise ValueError("n não pode ser negativo")

    if n == 0:
        return []
    elif n == 1:
        return [0]

    sequence = [0, 1]
    for i in range(2, n):
        sequence.append(sequence[i - 1] + sequence[i - 2])

    return sequence


def process_data(data: List[Dict]) -> Dict[str, Union[int, float]]:
    """
    Processa uma lista de dicionários e retorna estatísticas.

    Exemplo de função com type hints complexos.
    """
    if not data:
        return {"count": 0, "average": 0.0}

    total = sum(item.get("value", 0) for item in data)
    count = len(data)

    return {
        "count": count,
        "total": total,
        "average": total / count if count > 0 else 0.0,
        "max_value": max(item.get("value", 0) for item in data),
        "min_value": min(item.get("value", 0) for item in data),
    }


async def async_example() -> None:
    """Exemplo de função assíncrona"""
    import asyncio

    await asyncio.sleep(0.1)
    print("Função assíncrona executada")


def main() -> None:
    """Função principal do programa"""
    print("=" * 50)
    print("Testando plugins do Neovim com Python")
    print("=" * 50)

    # Teste 1: Criação de objetos
    person = Person("João Silva", 30, "joao@email.com")
    print("\n1. Teste de classe Person:")
    print(f"   {person.greet()}")
    print(f"   Email: {person.email}")

    # Teste 2: Calculadora
    print("\n2. Teste da Calculadora:")
    calc = Calculator()
    print(f"   10 + 5 = {calc.add(10, 5)}")
    print(f"   10 - 5 = {calc.subtract(10, 5)}")
    print(f"   10 * 5 = {calc.multiply(10, 5)}")

    try:
        print(f"   10 / 5 = {calc.divide(10, 5)}")
        print(f"   10 / 0 = {calc.divide(10, 0)}")
    except ValueError as e:
        print(f"   Erro: {e}")

    # Teste 3: Fibonacci
    print("\n3. Sequência de Fibonacci (10 primeiros):")
    fib = fibonacci(10)
    print(f"   {fib}")

    # Teste 4: Processamento de dados
    print("\n4. Processamento de dados:")
    data = [
        {"id": 1, "value": 100},
        {"id": 2, "value": 200},
        {"id": 3, "value": 150},
        {"id": 4, "value": 300},
        {"id": 5, "value": 250},
    ]

    stats = process_data(data)
    print(f"   Estatísticas: {json.dumps(stats, indent=2)}")

    # Teste 5: Expressões lambda e list comprehension
    print("\n5. Expressões lambda e list comprehension:")
    numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

    # Dobrar os números
    doubled = [n * 2 for n in numbers]
    print(f"   Números dobrados: {doubled}")

    # Filtrar números pares
    even_numbers = [n for n in numbers if n % 2 == 0]
    print(f"   Números pares: {even_numbers}")

    # Usando lambda
    def square(x):
        return x**2

    squares = list(map(square, numbers))
    print(f"   Quadrados: {squares}")

    # Teste 6: Match case (Python 3.10+)
    print("\n6. Match case (Python 3.10+):")

    def describe_number(n: int) -> str:
        match n:
            case 0:
                return "zero"
            case 1:
                return "um"
            case 2 | 3 | 5 | 7:
                return "número primo pequeno"
            case n if n < 0:
                return "número negativo"
            case n if n % 2 == 0:
                return "número par"
            case _:
                return "número ímpar"

    for num in [0, 1, 2, 4, 7, -5, 9]:
        print(f"   {num}: {describe_number(num)}")

    print("\n" + "=" * 50)
    print("Testes concluídos com sucesso!")
    print("=" * 50)


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n\nPrograma interrompido pelo usuário")
        sys.exit(0)
    except Exception as e:
        print(f"\nErro inesperado: {e}")
        sys.exit(1)
