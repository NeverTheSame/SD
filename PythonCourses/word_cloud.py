import wordcloud
import numpy as np
from matplotlib import pyplot as plt
from IPython.display import display
import fileupload
import io


"""
Before processing any text, you need to remove all the punctuation marks. 
To do this, you can go through each line of text, character-by-character, using the isalpha() method. 
This will check whether or not the character is a letter.
To split a line of text into words, you can use the split() method.
Before storing words in the frequency dictionary, check if they’re part of the "uninteresting" set of words 
(for example: "a", "the", "to", "if"). Make this set a parameter to your function so that you can change it if necessary.
"""


def _upload():
    """This is the uploader widget"""
    _upload_widget = fileupload.FileUploadWidget()

    def _cb(change):
        global file_data
        decoded = io.StringIO(change['owner'].data.decode('utf-8'))
        filename = change['owner'].filename
        print('Uploaded `{}` ({:.2f} kB)'.format(
            filename, len(decoded.read()) / 2 **10))
        file_data = decoded.getvalue()

    _upload_widget.observe(_cb, names='data')
    display(_upload_widget)


with open('Test.log', 'r') as file:
    file_data = ""
    for line in file:
        file_data += line.strip()


def calculate_frequencies(file_contents):
    # Here is a list of punctuations and uninteresting words you can use to process your text
    punctuations = '''!()-[]{};:'"\,<>./?@#$%^&*_~'''
    uninteresting_words = ["the", "a", "to", "if", "is", "it", "of", "and", "or", "an", "as", "i", "me", "my",
                            "we", "our", "ours", "you", "your", "yours", "he", "she", "him", "his", "her", "hers", "its",
                            "they", "them",
                            "their", "what", "which", "who", "whom", "this", "that", "am", "are", "was", "were", "be",
                            "been", "being",
                            "have", "has", "had", "do", "does", "did", "but", "at", "by", "with", "from", "here", "when",
                            "where", "how",
                            "all", "any", "both", "each", "few", "more", "some", "such", "no", "nor", "too", "very",
                            "can", "will", "just"]

    # LEARNER CODE START HERE
    word_dict = {}
    for word in file_contents.split(" "):
        word = word.lower()
        if word.isalpha() and word not in uninteresting_words:
            if word in word_dict:
                word_dict[word] += 1
            else:
                word_dict[word] = 1
    # print(word_dict)


    # wordcloud
    cloud = wordcloud.WordCloud()
    cloud.generate_from_frequencies(word_dict)
    return cloud.to_array()


# Display your wordcloud image

myimage = calculate_frequencies(file_data)
plt.imshow(myimage, interpolation = 'nearest')
plt.axis('off')
plt.show()