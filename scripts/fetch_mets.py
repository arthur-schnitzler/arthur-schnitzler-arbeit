import os
from transkribus_utils.transkribus_utils import ACDHTranskribusUtils

user = os.environ.get("TR_USER")
pw = os.environ.get("TR_PW")
col_id = os.environ.get("COL_ID")
doc_id = os.environ.get("DOC_ID")

transkribus_client = ACDHTranskribusUtils(
    user=user, password=pw, transkribus_base_url="https://transkribus.eu/TrpServer/rest"
)

#mpr_docs = transkribus_client.document_to_mets(
#mpr_docs = transkribus_client.collection_to_mets(col_id, file_path='./mets')
mpr_docs = transkribus_client.collection_to_mets(
    col_id,
    file_path="./mets",
    filter_by_doc_ids=[
        doc_id,
    ],
)
