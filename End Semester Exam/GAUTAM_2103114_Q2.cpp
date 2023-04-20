#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

// Function to calculate the accuracy of the always taken predictor
float alwaysTaken(vector<int> outcomes)
{
    int correct_predictions = count(outcomes.begin(), outcomes.end(), 1);
    return (float)correct_predictions / outcomes.size() * 100;
}

// Function to calculate the accuracy of the always not taken predictor
float alwaysNotTaken(vector<int> outcomes)
{
    int correct_predictions = count(outcomes.begin(), outcomes.end(), 0);
    return (float)correct_predictions / outcomes.size() * 100;
}

// Function to calculate the accuracy of the one-bit predictor
float oneBitPredictor(vector<int> outcomes)
{
    int correct_predictions = 0;
    bool prediction = 1; // Start with taken prediction
    for (int i = 0; i < outcomes.size(); i++)
    {
        if (outcomes[i] == prediction)
        {
            correct_predictions++;
        }
        else
        {
            prediction = outcomes[i];
        }
    }
    return (float)correct_predictions / outcomes.size() * 100;
}

// Function to calculate the accuracy of the two-bit predictor
float twoBitPredictor(vector<int> outcomes, int start_state)
{
    int correct_predictions = 0;
    int state = start_state;
    for (int i = 0; i < outcomes.size(); i++)
    {
        // Make prediction based on current state
        bool prediction = (state == 2 || state == 3);
        // Check if prediction is correct
        if (outcomes[i] == prediction)
        {
            correct_predictions++;
        }
        else
        {
            // Update state based on whether the prediction was taken or not taken
            if (outcomes[i])
            {
                if (state < 3)
                    state++;
            }
            else
            {
                if (state > 0)
                    state--;
            }
        }
    }
    return (float)correct_predictions / outcomes.size() * 100;
}

int main()
{
    // Branch outcomes for verification
    vector<int> outcomes_a = {1, 1, 0, 1};                   // T,T,NT,T
    vector<int> outcomes_b = {1,1,1,0,0};       // T,T,T,NT,NT
    vector<int> outcomes_c = {1, 1, 0, 1};  // T,T,NT,T

    // Verification for part (A)
    cout << "Verification for part (A):" << endl;
    cout << "Always taken predictor accuracy: " << alwaysTaken(outcomes_a) << "%" << endl;
    cout << "Always not taken predictor accuracy: " << alwaysNotTaken(outcomes_a) << "%" << endl;
    cout << "One-bit predictor accuracy: " << oneBitPredictor(outcomes_a) << "%" << endl;

    // Verification for part (B)
    cout << endl
         << "Verification for part (B):" << endl;
    cout << "Always taken predictor accuracy: " << alwaysTaken(outcomes_b) << "%" << endl;
    cout << "Always not taken predictor accuracy: " << alwaysNotTaken(outcomes_b) << "%" << endl;
    cout << "One-bit predictor accuracy: " << oneBitPredictor(outcomes_b) << "%" << endl;

    // Verification for part (C)

    cout << endl;
    cout << "Verification for part (C):" << endl;
    cout << "Two-bit predictor accuracy (starting state = 0): " << twoBitPredictor(outcomes_b, 0) << "%" << endl;
    cout << "Two-bit predictor accuracy (starting state = 1): " << twoBitPredictor(outcomes_b, 1) << "%" << endl;
    cout << "Two-bit predictor accuracy (starting state = 2): " << twoBitPredictor(outcomes_b, 2) << "%" << endl;
    cout << "Two-bit predictor accuracy (starting state = 3): " << twoBitPredictor(outcomes_b, 3) << "%" << endl;

    // Order of decreasing accuracy for two-bit predictor starting from all possible states
    // vector<int> accuracy_order = {twoBitPredictor(outcomes_c, 3), twoBitPredictor(outcomes_c, 1),
    //                               twoBitPredictor(outcomes_c, 0), twoBitPredictor(outcomes_c, 2)};
    vector<int> accuracy_order = {static_cast<int>(twoBitPredictor(outcomes_c, 0)), 
                              static_cast<int>(twoBitPredictor(outcomes_c, 1)), 
                              static_cast<int>(twoBitPredictor(outcomes_c, 2)), 
                              static_cast<int>(twoBitPredictor(outcomes_c, 3))};

    sort(accuracy_order.begin(), accuracy_order.end(), greater<int>());
    cout << "Order of decreasing accuracy for two-bit predictor starting from all possible states: ";
    for (int i = 0; i < accuracy_order.size(); i++)
    {
        cout << accuracy_order[i] << "% ";
    }
    cout << endl;

    return 0;
}
