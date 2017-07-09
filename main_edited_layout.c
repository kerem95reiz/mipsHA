#include <stdio.h>
#include <stdlib.h>
#include <memory.h>

typedef int bool;
#define true 1;
#define false 0;

typedef enum {FROMREADTASK, FROMMAIN} from_where;

int cleanIrrelChars(FILE *x);
void writeToTheFile(FILE *output, int** totReq, int** usageOfTheRes, int* capOfRes, int numSimPro, int numSimRes);
void compRestMatr(FILE *addRestMat, int** totReq, int** usageOfTheRes, int** restReq, int* capOfRes, int numSimPro, int numSimRes);
int safeOrUnsafe(FILE *addRestMat, int** restReq, int** usageOfTheRes, int* capOfRes, int numSimRes, int numSimPro, int plusHighestRes, from_where fromWhere);
void printTheOperation(FILE* addRestMat, int** restReq, int* capOfRes,int numSimPro, int numSimRes, int readCharacter, int whichProc, int whichRes, int howManyRes);
void readTheTasks(FILE* input,FILE* addRestMat , int** restReq, int** usageOfTheRes, int* capOfRes, int numSimPro, int numSimRes, int plusHighestRes);
int** createCopyMatrix(int** restReq, int numSimPro, int numSimRes);
int* createCopyArray(int* capOfRes, int numSimRes);


int main(int argc, char* argv[]) {
    int readChar, numSimPro = -1, numSimRes = -1, plusHighestRes = 0;

    if (argc < 2){
        printf("There is not enough arguments!\nMake sure that you entered the input and output file's adresses.\n");
        return -1;
    }

    FILE *input = fopen(argv[1], "r");
    FILE *output = fopen(argv[2], "w");
    FILE *addRestMat = fopen(argv[2], "a");

    if (input==NULL){
        printf("The input file could not be opened!\n");
        return -1;
    }

    // From now we are gonna read the content of the input file
    //////////////////////////////////////////////////////////////
    //_read Process and Resource
    for (int i = 0; i < 5; ++i) {
        readChar = fgetc(input);
        if (i == 1){
            numSimPro = readChar - 48;
        } else if (i == 4){
            numSimRes = readChar - 48;
        }
        //_end read Process and Resource
    }

    // Creating a matrix to save the requirements matrix
    int** totReq = (int**)malloc(numSimPro * sizeof(int*));

    // For each line/process, we assign a new set of memory address
    for (int l = 0; l < numSimPro; ++l) {
        totReq[l] = (int*)malloc(numSimRes * sizeof(int));
    }


    // Creating a matrix to save the (Belegung) usage of the resources matrix
    int** usageOfTheRes = (int**)malloc(numSimPro * sizeof(int*));

    // For each line/process, we assign a new set of memory address
    for (int l = 0; l < numSimPro; ++l) {
        usageOfTheRes[l] = (int*)malloc(numSimRes * sizeof(int));
    }

    int** restReq = (int**)malloc(numSimPro * sizeof(int));

    for (int j1 = 0; j1 < numSimPro; ++j1) {
        restReq[j1] = (int*) malloc(numSimRes * sizeof(int));
    }

    // The capacity of existing resources
    int *capOfRes = (int*)malloc(sizeof(int)*numSimRes);


    // We read the with the outer loop every process and with the other loop the resources
    // and then we assign the read values into the requirements matrix
    for (int j = 0; j < numSimPro; ++j) {
        for (int i = 0; i < numSimRes; ++i) {
            // If the read character is really a number, not a newLine or something else
            totReq[j][i] = cleanIrrelChars(input) - 48;
        }
    }

    // We read the with the outer loop every process and with the other loop the resources
    // and then we assign the read values into the resources matrix
    for (int j = 0; j < numSimPro; ++j) {
        for (int i = 0; i < numSimRes; ++i) {
            // If the read character is really a number, not a newLine or something else
            usageOfTheRes[j][i] = cleanIrrelChars(input) - 48;
        }
    }

    for (int k = 0; k < numSimRes; ++k) {
        capOfRes[k] = cleanIrrelChars(input) - 48;
    }
    //////////////////////////////////////////////////////
    //This step will write the A Aufgabe into output file.
    writeToTheFile(output, totReq, usageOfTheRes, capOfRes, numSimPro, numSimRes);

    // That'll be used to sign that a vector (a process) has already accomplished
    // For that we need a bigger value than the free resource
    for (int m = 0; m < numSimRes; ++m) {
        if (plusHighestRes < capOfRes[m]){
            plusHighestRes = capOfRes[m];
        }
    }
    plusHighestRes++;

    /////////////
    // Aufgabe b
    compRestMatr(addRestMat, totReq, usageOfTheRes, restReq, capOfRes, numSimPro, numSimRes);

    // Because we change the content of the matrix in the safeOrUnsafe routine, we need to clone the matrix before we proceed with c and d.
    int** restReqOrg = createCopyMatrix(restReq, numSimPro, numSimRes);
    int** usageOfTheResOrg = createCopyMatrix(usageOfTheRes, numSimPro, numSimRes);
    int* capOfResOrg = createCopyArray(capOfRes, numSimRes);

    ////////////
    // Aufgabe c
    safeOrUnsafe(addRestMat, restReqOrg, usageOfTheResOrg, capOfResOrg, numSimRes, numSimPro, plusHighestRes, FROMMAIN);
    ///////////////////////////
    // Aufgabe d faengt hier an
    readTheTasks(input, addRestMat, restReq, usageOfTheRes, capOfRes, numSimPro, numSimRes, plusHighestRes);

    fclose(input);
    fclose(output);

    return 0;
}

/////////////////////////////
//THIS IS METHODE  AUFGABE D
/////////////////////////////
void readTheTasks(FILE* input,FILE* addRestMat , int** restReq, int** usageOfTheRes, int* capOfRes, int numSimPro, int numSimRes, int plusHighestRes){
    int readCharacter, whichProc, whichRes, howManyRes;

    // For every operation should loop this once. From Vorlesung.
    while ((readCharacter = fgetc(input)) != EOF){

        // When we want to allocate some places in out memory, then go into the first section, to release something into the else section
        if (readCharacter == 65){
            printf("\n::::::::: HERE1 ::::::::\n");

            whichProc = cleanIrrelChars(input) - 48;
            whichRes = cleanIrrelChars(input) - 48;
            howManyRes = cleanIrrelChars(input) - 48;

            // Somewhere here there is a mistakte..Find it!!!!
            int** tempRestReq = createCopyMatrix(restReq, numSimPro, numSimRes);
            int* tempCapOfRes = createCopyArray(capOfRes, numSimRes);
            int** tempusageOfTheRes = createCopyMatrix(usageOfTheRes, numSimPro, numSimRes);

            for (int i = 0; i < howManyRes; ++i) {
                tempRestReq[whichProc][whichRes] -= 1;
                tempCapOfRes[whichRes] -= 1;
            }


            int isSafe = safeOrUnsafe(addRestMat, tempRestReq, tempusageOfTheRes, tempCapOfRes, numSimRes, numSimPro, plusHighestRes, FROMREADTASK);
            printf("\n::::::::: HERE2 ::::::::\n");

            if (isSafe == 0){
                continue;
            } else {
                break;
            }
            printf("\n::::::::: HERE3 ::::::::\n");

            // Because we allocate in each loop, we should throw at each time another requiremt, since it's not a requirement anymore :)
            for (int i = 0; i < howManyRes; ++i) {
                restReq[whichProc][whichRes] -= 1;
                usageOfTheRes[whichProc][whichRes] += 1;
                capOfRes[whichRes] -= 1;
            }

            printTheOperation(addRestMat, restReq, capOfRes, numSimPro, numSimRes, readCharacter, whichProc, whichRes, howManyRes);

        } else if (readCharacter == 82){

            whichProc = cleanIrrelChars(input) - 48;
            whichRes = cleanIrrelChars(input) - 48;
            howManyRes = cleanIrrelChars(input) - 48;

            int** tempRestReq = createCopyMatrix(restReq, numSimPro, numSimRes);
            int* tempCapOfRes = createCopyArray(capOfRes, numSimRes);
            int** tempusageOfTheRes = createCopyMatrix(usageOfTheRes, numSimPro, numSimRes);

            for (int i = 0; i < howManyRes; ++i) {
                tempusageOfTheRes[whichProc][whichRes] -= 1;
                tempCapOfRes[whichRes] += 1;
            }

            int isSafe = safeOrUnsafe(addRestMat, tempRestReq, tempusageOfTheRes, tempCapOfRes, numSimRes, numSimPro, plusHighestRes, FROMREADTASK);
            printf("\n::::::::: HERE ::::::::\n");
            if (isSafe == 0){
                continue;
            } else {
                break;
            }

            for (int i = 0; i < howManyRes; ++i) {
                usageOfTheRes[whichProc][whichRes] -= 1;
                capOfRes[whichRes] += 1;
            }
            printTheOperation(addRestMat, restReq, capOfRes, numSimPro, numSimRes, readCharacter, whichProc, whichRes, howManyRes);
        }
    }
}


void printTheOperation(FILE* addRestMat, int** restReq, int* capOfRes,int numSimPro, int numSimRes, int readCharacter, int whichProc, int whichRes, int howManyRes){
    fprintf(addRestMat, "Operation: %c %d %d %d\n\nRestanforderungen:\n", readCharacter, whichProc, whichRes, howManyRes);
    for (int j = 0; j < numSimPro; ++j) {
        for (int i = 0; i < numSimRes; ++i) {
            if (i == 0){
                fprintf(addRestMat, " ");
            } else{
                fprintf(addRestMat, "  ");
            }
           putc(restReq[j][i]+48, addRestMat);
        }
        fprintf(addRestMat, "\n");
    }
    fprintf(addRestMat, "\n");

    fprintf(addRestMat, "f:");
    for (int k = 0; k < numSimRes; ++k) {
        fprintf(addRestMat, "  %d", capOfRes[k]);
    }
    fprintf(addRestMat, "\n\n");

}
////////////////////////////////////
//END OF METHODE DOES THE AUFGABE D
////////////////////////////////////


int cleanIrrelChars(FILE *x){
    int readChar;
    while (1){
        readChar = fgetc(x);
        if (readChar >= 48 && readChar <= 57){
            return readChar;
        }
    }
}

void writeToTheFile(FILE *output, int** totReq, int** usageOfTheRes, int* capOfRes, int numSimPro, int numSimRes){


    fprintf(output ,"Prozesse:  %d / Betriebsmittel:  %d\n\n", numSimPro, numSimRes);

    fprintf(output, "Gesamtanforderungen:\n");
    for (int i1 = 0; i1 < numSimPro; ++i1) {
        for (int i = 0; i < numSimRes; ++i) {
            if (i == 0){
                fprintf(output, " ");
            } else{
                fprintf(output, "  ");
            }
            putc(totReq[i1][i]+48, output);
        }
        fprintf(output, "\n");
    }
    fprintf(output, "\n");

    fprintf(output, "Belegungen:\n");
    for (int i1 = 0; i1 < numSimPro; ++i1) {
        for (int i = 0; i < numSimRes; ++i) {
            if (i == 0){
                fprintf(output, " ");
            } else{
                fprintf(output, "  ");
            }
            putc(usageOfTheRes[i1][i]+48, output);
        }
        fprintf(output, "\n");
    }
    fprintf(output, "\n");

    fprintf(output, "verfügbar:");
    for (int j1 = 0; j1 < numSimRes; ++j1) {
        fprintf(output ,"  ");
        putc(capOfRes[j1]+48, output);
    }
    fprintf(output, "\n");

}



/////////////////////////////
//BBBBBBBBBBBBBBBBBBBBBBBBBBB
/////////////////////////////
void compRestMatr(FILE *addRestMat, int** totReq, int** usageOfTheRes, int** restReq, int* capOfRes, int numSimPro, int numSimRes){
    //Computing the restRequirements (Restanforderungen)
    for (int i1 = 0; i1 < numSimPro; ++i1) {
        for (int i = 0; i < numSimRes; ++i) {
            restReq[i1][i] = totReq[i1][i] - usageOfTheRes[i1][i];
            capOfRes[i] = capOfRes[i] - usageOfTheRes[i1][i];
        }
    }

    // We need to add the new coputed matrix to the file
    fprintf(addRestMat ,"\nRestanforderungen:\n");
    for (int k1 = 0; k1 < numSimPro; ++k1) {
        for (int i = 0; i < numSimRes; ++i) {

            if (i == 0){
                fprintf(addRestMat, " ");
            } else{
                fprintf(addRestMat, "  ");
            }
            putc(restReq[k1][i]+48, addRestMat);
        }
        fprintf(addRestMat, "\n");
    }
    fprintf(addRestMat, "\n");

    fprintf(addRestMat, "frei: ");
    for (int l1 = 0; l1 < numSimRes; ++l1) {

        if (l1 == 0){
            fprintf(addRestMat, " ");
        } else{
            fprintf(addRestMat, "  ");
        }
        putc(capOfRes[l1] + 48, addRestMat);
    }
    fprintf(addRestMat, "\n");
}
/////////////////////////////
//End-BBBBBBBBBBBBBBBBBBBBBBB
/////////////////////////////


/////////////////////////////
//CCCCCCCCCCCCCCCCCCCCCCCCCCC
/////////////////////////////
int safeOrUnsafe(FILE *addRestMat, int** restReq, int** usageOfTheRes, int* capOfRes, int numSimRes, int numSimPro, int plusHighestRes, from_where fromWhere){

    int safe = 1, unsafe = 0, currsit = -1;
    int counter = 0, numExtractedPro = 0, skippedTimes = 0;
    bool existProcess;

    while (currsit == -1){
        existProcess = true;
        for (int i = 0; i < numSimRes; ++i) {
            if (restReq[counter][i] <= capOfRes[i]){
                existProcess = existProcess && true;
            } else{
                existProcess = false;
            }
        }

        if (existProcess){
            for (int i = 0; i < numSimRes; ++i) {
                capOfRes[i] += usageOfTheRes[counter][i];
                usageOfTheRes[counter][i] = 0;
                // That is zero, because we have already compeleted the process and that's why we don't need to get anything anymore
                restReq[counter][i] = plusHighestRes;
            }
            numExtractedPro++;
            skippedTimes = 0;
        } else{
            // how many times we skipped
            skippedTimes++;
        }

        // Now we need to know whether still an element exist in the restMatrix
        // If it doesnot, then we need to say it's secure
        // Otherwise it is not!
        if (numExtractedPro == numSimPro && skippedTimes == numSimPro){
            currsit = 1;
        } else if (numExtractedPro < numSimPro && skippedTimes == numSimPro){
            currsit = 0;
        }
        counter = (counter+1) % numSimPro;
    }
    if (currsit == 1){
        if (fromWhere == FROMMAIN) fprintf(addRestMat, "\nSICHER\n");
        return safe;
    } else if (currsit == 0){
        if (fromWhere == FROMMAIN) fprintf(addRestMat, "\nUNSICHER\n");
        return unsafe;
    }
    return -1;
}
/////////////////////////////
//End-CCCCCCCCCCCCCCCCCCCCCCC
/////////////////////////////


int* createCopyArray(int* capOfRes, int numSimRes){
    int* capOfResOrg = (int*)malloc(numSimRes * sizeof(int));
    for (int i1 = 0; i1 < numSimRes; ++i1) {
        capOfResOrg[i1] = capOfRes[i1];
    }
    return capOfResOrg;
}



int** createCopyMatrix(int** restReq, int numSimPro, int numSimRes){
    int** restReqOrg = (int**)malloc(numSimPro*sizeof(int*));
    for (int k1 = 0; k1 < numSimPro; ++k1) {
        restReqOrg[k1] = (int*) malloc(numSimRes*sizeof(int));
    }

    for (int n = 0; n < numSimPro; ++n) {
        for (int i = 0; i < numSimRes; ++i) {
            restReqOrg[n][i] = restReq[n][i];
        }
    }

    return restReqOrg;
}




























