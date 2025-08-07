# OnChip_SNN_Accelerator_Edge
This design presents an on-chip spiking neural network (SNN) neuromorphic accelerator design deploying biologically inspired training for low power Edge-AI classification tasks.


# Brief Details

## Structure

- This repo contains a complete **Spiking Neural Network (SNN)** architecture with 3 layers:
  - **Input Layer**:
    - Contains one input neuron
    - Each input is 16 bits wide (word size)
  - **Hidden Layer**:
    - Contains 16 recurrent neurons
    - Each neuron includes an **on-chip unsupervised learning engine** for weight updates
  - **Readout Layer**:
    - Contains 2 output neurons
    - Each neuron includes a **supervised learning engine** for on-chip training
    - For a given sample spike train, whichever of the readout neuron spikes most frequently, that associated target label is chosen as predicted label

## Functions

- The input neuron encodes and sends spike trains to the hidden layer
- Hidden layer neurons:
  - Begin spiking in response to input spikes
  - Send spike responses to both the readout layer and recurrently to other hidden neurons
- Hidden layer weights are updated over a set number of iterations using **unsupervised STDP**
- Once converged, the hidden layer weights are **frozen**
- The final spiking states from the hidden layer are forwarded to the readout layer
- The readout layer is trained using **supervised STDP**
- After training:
  - Both hidden and readout weights are frozen
  - The SNN is ready for **inference**



## 📄 Project Presentation (PDF)

Click the image below to briefly overview the project presentation:

[![Project Report Preview](https://github.com/muhammadfarhan720/OnChip_SNN_Accelerator_Edge/blob/main/image/project_thumbnail.jpg))](https://github.com/muhammadfarhan720/OnChip_SNN_Accelerator_Edge/blob/main/Presentation_Neuromorph_Accelerator.pdf)))
