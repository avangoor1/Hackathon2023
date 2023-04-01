import requests
from bs4 import BeautifulSoup
import json
import html_to_json
import flask
from flask import Flask, request, jsonify


app = Flask(__name__)
@app.route('/plants/<string:name>')
def get_plant_info(name):
    URL = "https://harvesttotable.com/how_to_grow_" + name + "/"
    r = requests.get(URL)

    soup = BeautifulSoup(r.content, 'html5lib')

    # Write raw HTML to file
    with open('PlantRawHtmlData.json', 'w') as json_file:
        json.dump(str(soup), json_file)


    # Extract 'li' elements and write to file
    li_processed_soup = soup.find_all("li")
    li_list = [str(li) for li in li_processed_soup]
    with open('LiProcessedJsonData.json', 'w') as json_file:
        json.dump(li_list, json_file)

    # Search for keyword "water" in LiProcessedJsonData.json and write to file "WaterText.json"
    with open('LiProcessedJsonData.json') as json_file:
        data = json.load(json_file)
        water_list = [li for li in data if "water" in li]
        with open('WaterText.json', 'w') as json_file:
            json.dump(water_list, json_file)


    return jsonify(water_list)
if __name__ == '__main__':
    app.run(debug=True)
