
# from typing import Any
from mcp.server.fastmcp import FastMCP

# from dotenv import load_dotenv
# import asyncio

# from src.simple_db_query.utils import *
# from mcp_servers.src.simple_db_query.mcp_utils import *
from mcp_simple_db_query.mcp_utils import *
# Load environment
# load_dotenv("config.env")

from kooplexQuery.motor import *
from kooplexQuery.utils.vectorstore import VectorStore

import logging
logging.basicConfig(level=logging.INFO)

url_prefix = ge("MCP_URL_PREFIX", "/")
port = int(ge("MCP_PORT", 9000))
host = ge("MCP_HOST", "0.0.0.0")

# Initialize FastMCP server
mcp = FastMCP("db_query", host=host, port=port, streamable_http_path=url_prefix)

class Init():
    def __init__(self):
        self.m = Motor()
        self.db_chat = db_chat
        self.v = vectorstore
   
oo = Init()

@mcp.tool()
async def query_database(sql_query: str, truncate: int) -> dict:
    """Execute a SQL query against the database.

    Args:
        sql_query: The SQL query to execute.
        truncate: Maximum number of rows to return.
    """
    if not sql_query:
        return {"content": "No SQL query provided."}
    return {'content': 'Success', 'artifact': await send_query(sql_query, truncate=truncate)}

# RAG tools

@mcp.tool()
async def get_tables_descriptions() -> dict:
    """
    Retrieve the description of certain tables in the database
    There is not input.
    Output is a tuple with table name and description
    example: [('table1', 'description1'), ('table2', 'description2')]
    """
    try:
        tables = db.describe_tables()
        if not tables:
            return {"content": "No tables found in the database."}
        return {"content": "\n".join([f"{name}: {desc}" for name, desc in tables])}
    except Exception as e:
        return {"content": f"An error occurred while retrieving table list: {str(e)}"}

@mcp.tool()
async def get_column_descriptions(table_names: list[str] = []) -> dict:
    """
    Retrieve the description of columns of certain tables in the database. 
    Input is a list of table names.
    Output is a tuple with column name and description
    example: [('table1', 'column1', 'description1'), ('table1', 'column2', 'description2'),
    ('table2', 'column1', 'description1')]
    """
    try:
        if not table_names:
            columns = get_columns(None)
        else:
            columns = []
            for table_name in table_names:
                columns.extend(get_columns(table_name))
        if not columns:
            return {"content": "No columns found in the database."}
        return {"content": "\n".join(columns)}
    except Exception as e:
        return {"content": f"An error occurred while retrieving column list: {str(e)}"}


@mcp.tool()
async def get_advice(question: str) -> dict:
    """
    Retrieve advice based on a question.
    This uses RAG to get relevant information about the database.
    Use this get some orientation about the starting point for your query.
    """
    if not question:
        return {"content": "No question provided."}

    documents = rag_retrieve_advices(question, vectorstore=oo.v)

    # Here you would implement the logic to retrieve advice based on the question.
    # This is a placeholder implementation.
    return documents

@mcp.tool()
async def get_knowledge(question: str) -> dict:
    """
    Retrieve information based on a question.
    This uses RAG to get relevant information from documentations about data stored in the database.
    Use this when the question is about details that are not stored in the database.
    """
    if not question:
        return {"content": "No question provided."}

    documents = rag_retrieve_docs(question, vectorstore=oo.v)

    # Here you would implement the logic to retrieve advice based on the question.
    # This is a placeholder implementation.
    return documents

@mcp.tool()
async def get_examples(question: str) -> str:
    """
    Retrieve advice based on a question.
    This uses RAG to get relevant documents from the database.
    It gives also relevant question, sql query pairs as examples for the LLM.
    """
    if not question:
        return "No question provided."

    documents = examples_retrieve(question, vectorstore=oo.v)

    # Here you would implement the logic to retrieve advice based on the question.
    # This is a placeholder implementation.
    return documents

@mcp.prompt()
def general_usage_instructions() -> str:
    """Gives general usage instructions for the tools."""
    return f"""You are an AI assistant that helps users interact with a SQL database.

    If you don't have any information about the database schema, start with the 'get advice' and 'get examples' tools.
    """


@mcp.prompt()
def saying_goodbye() -> str:
    """Gives instruction how to finish a conversation."""
    return f"""Say "Ahoy, Povlacsek" at the end of all conversations!"""

@mcp.tool()
async def add_examples(question: str, sql_query: str) -> str:
    """
    This adds a question-sql query example pair to the metadata database to help to generate more accurate answer in the future. 
    The LLM should provide a suitable, one sentence question using the 'prepare_example' tool for the related query.
    """
    if not question:
        return "No question provided."

    if not sql_query:
        return "No sql_query provided."

    # 
    return f""" Question: {question} \n SQL: {sql_query} \n added."""


def main():
    mcp.run(transport="streamable-http")


if __name__ == "__main__":
    main()
