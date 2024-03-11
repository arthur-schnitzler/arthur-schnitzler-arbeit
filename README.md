# Forget you've ever been here! Just hop on to https://github.com/arthur-schnitzler/schnitzler-briefe-data

This is the where we work on Arthur Schnitzler - Briefe. We’re not trying to document everything we do here. So quite frankly: You don't want this. Please go away!

# GitHub Action "Download and process"

The GitHub Action exports METS from Transkribus and converts them to XML/TEI.

* set Github Secrets as in `./env-sample`
* go to Actions, add the ID of the collection and the document to process

Code originally from @csae8092, adaptions by @laurauntner

The original page2tei-transformation is from @dariok with contributions from @tboenig, @peterstadler and @tillgrallert.