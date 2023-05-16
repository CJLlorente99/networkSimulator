#include "csvUtilities.hpp"

using namespace csvUtilities;

CSVReader::CSVReader(std::string filename, char delimiter){
    this->file = std::ifstream(filename);
    this->delimiter = delimiter;
}

int CSVReader::readNextLine(std::vector<bool> *inputs){
    std::vector<bool> row;
    std::string line, word;
    bool aux;
    while (std::getline(this->file, line)) {
        std::stringstream ss(line);

        while (std::getline(ss, word, this->delimiter)){
            if (word == "1")
                aux = true;
            else if (word == "0")
                aux = false;
            row.push_back(aux);
        *inputs = row;
        return 1;   
        }
    return 0;   
    }
}

CSVWriter::CSVWriter(std::string filename, char delimiter){
    this->file = std::ofstream(filename);
    this->delimiter = delimiter;
}

int CSVWriter::writeHeader(std::vector<std::string> columnHeaders){
    for (int i = 0; i < columnHeaders.size(); i++)
        this->file << columnHeaders[i] << this->delimiter;
    this->file << std::endl;
    return 1;
}

int CSVWriter::writeNextLine(std::vector<bool> outputs){
    for (int i = 0; i < outputs.size(); i++)
        this->file << outputs[i] << this->delimiter;
    this->file << std::endl;
    return 1;
}