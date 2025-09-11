---
title: "How I Use LLM's to Extract Structured Data"
publication_date: "2025-09-12"
tags: ["llm", "ai", "ocr", "document parsing", "structured data extraction"]
---
# How I Use LLM's to Extract Structured Data

Large language models (aka AI) are a hot topic right now. Some consider LLM's the greatest thing that ever existed while others think it's the doom of society as we know and everything will go downhill from here. Wow, bold statements, not packing a lot of good sense in them. It seems outrageous just to write that down, but I've seen some crazy things out there kids. Crazy things! We'll let's focus on what we know, it's pretty incredible how far we've come and the things we can do with these generational models.

One of the things I learned it can do well is understand text and transform that in a structured format, so that it can be used by our beloved software systems. I'll try to show you how you can extract text from pdf documents, supposedly documents with many formats and layouts and make it into a json.

So think about a PDF document, it could be the receipt you got this morning from your preferred coffee shop, an invoice for your netflix subscription or a quote for repairing your car. You probably see many of these every day, imagine a large company, they handle hundreds, if not thousands of these every day.

These documents come in many shapes and forms, it could be pdfs, sometimes be images, maybe they come embedded in emails or maybe they are spreadsheets. We'll that's a lot, but if you can turn it into text, there is a big change you can use an LLM to make it into a structured format.

We can find out of the box solutions out there but with the expense documents I've worked with, the LLM approach worked better, even more when the document shape is not as common.

Well, there are many ways to extract data with LLM's depending on the model provider you are using, here I'll share what worked for me with a relatively low budget and how you can accomplish something similar. It's a simple 2 step approach. The first step is to make your document into plain text and then fedd that to an llm instructing the format you want as a result.

Let's walk through the first step...

## Text Extraction

This step consists of extracting, as the title says, content from the documents. Once the LLM's understand text you need to figure out a way of transforming your pdf, image, spreadsheet into text so that the model can process it.

Depending on the model you are using, this step can be skipped and I think currently most models accept images or documents so you don't even have to extract the text, the model will do that for you. This was definitely not the case when I started using this approach for data extraction.

Even with the model allowing you to just send a file, handling the extraction yourself can still be useful if you want to massage the data before you send it to avoid noise. Depending on your business needs it might be required, if not, just skip it.

The common practice is to use OCR (Optical Character Recognition) for text extraction, OCR is the technique where an algorithm can "look" into an image and based on the pixel arrangement figure out which letters are present in the image and where. There are many well known paid services and open source tools that you can use for that. I'll leave a list of some popular choices at the end.

The OCR route is generally the more reliable and required if you are dealing with images or encrypted pdfs, for other loosely structured formats like html and most PDFs we can use simple tools like [`pdftotext`](https://www.xpdfreader.com/pdftotext-man.html) to get what we need and for simplicity's sake that's what we'll do. 

```bash
pdftotext file_name.pdf -layout -
```

The command above is all you need to extract text from a regular pdf, you also have options to only extract parts of  the  document or save it to a text file on disk. Since we are running it inside elixir I want whole extracted text spit out so I can send it further to the LLM.

Once we have the text, it's time for the transformation prompt...

## Transformation Prompt

This step consists of getting the extracted text into an LLM prompt so that the chosen model can perform the transformation.

This is a simplified example of the system prompt for extracting basic data from an invoice.
````
Extract invoice data and return ONLY valid JSON in this exact format:

```json
{
  "total": 0.00,
  "items": [
    {
      "item_id": "string or null",
      "description": "string",
      "price": 0.00
    }
  ]
}
```

Rules:
- Extract the invoice total and all line items
- Use null if item_id is not present
- Format all amounts with 2 decimal places
- Return ONLY the JSON object - no explanations or markdown
````

As you can see in the example, we have to instruct the model to extract what we want, it's effective to sometimes describe what the value you are trying to extract looks like and what it means, this will trigger the llm "neurons" to make connections to the data point you are trying to extract and return better results. The prompt will vary depending on the model, test it out and see what works best for you. Take a look at this [example](/public/articles/structured-data-extraction-llms/prompt.txt) for a more comprehensive extraction prompt.

In the old days (6 months ago) you would need to explicitly ask for json format in the prompt, sometimes more than once, although currently most api's have an option to explicily ask for json output. OpenAI for example has the `response_format` option where you can pass `{"type": "json_object"}` and it will force the model to avoid explanations and just return json.

This extraction technique can work well with smaller models, like claude sonnet, and gpt4.1-mini, I even had some success with small local models like qwen2.5 and phi4 using ollama.

## Closing

This extraction technique can do wonders when dealing with multiple formats of data. I've used it in a few use cases, like: Ingesting orders from receipts pictures, Parsing inbound quotes in a procurement system and reading parts manuals to make the parts data available in the system. I know some TLS systems use this same technique to extract candidates data for resumes.

This technique works surprisingly well and keeps improving as the models get better.

Check out this [example with elixir](https://gist.github.com/robsonperassoli/cc1ed743a99132f1b42ee5dbfd0b05a9) and OpenAI. I've tested it with a couple of sample invoices, the invoice files are linked into the gist comments for you to try it out. Feel free to change the prompt to extract invoice number, item quantity and so on if you feel like it.

### List of OCR tools

- Google Vision AI
- AWS Textract Document Analysis
- [DocTR](https://github.com/mindee/doctr)
- Tesseract
- EasyOCR
- RapidOCR
- olmoOCR
