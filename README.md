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
  - **Output Layer**:
    - Contains 2 output neurons for binary classification
    - Each neuron includes a **supervised learning engine** for on-chip training
    - For a given sample spike train, whichever of the output layer neuron spikes most frequently, that associated target label is chosen as predicted label


<img width="1319" height="286" alt="Full_Spiking_Network_Architecture" src="https://github.com/user-attachments/assets/18f4de47-7ace-4c62-b6b3-3536e4a67e78" />




## Functions

- The input neuron encodes and sends spike trains to the hidden layer
- Hidden layer neurons:
  - Begin spiking in response to input spikes
  - Send spike responses to both the output layer and recurrently to other hidden neurons
- Hidden layer weights are updated over a set number of iterations using **unsupervised STDP**
- Once converged, the hidden layer weights are **frozen**
- The final spiking states from the hidden layer are forwarded to the output layer
- The output layer is trained using **supervised STDP** with teacher signals
- After training:
  - Both hidden and output weights are frozen
  - The SNN is ready for **inference**







# Generic Architecture of a digital spiking neuron with learning engine  

![LIFnew_latest_Github](https://github.com/user-attachments/assets/37dc702e-2449-46c3-975b-afa84f0358f1)

- The spiking neurons of both hidden layer and output layer follows similar architecture. The only difference is within the **"Weight Update Learning Engine Type**
- The weights are imported from the learning engine at once using PISO weight
- The spikes from the previous layer and from own layer recurrent connections are imported using PISO Spike  


## 📄 Project Presentation (PDF)

Click the image below to briefly overview the project presentation:

[![Project Report Preview](https://github.com/muhammadfarhan720/OnChip_SNN_Accelerator_Edge/blob/main/image/project_thumbnail.jpg))](https://github.com/muhammadfarhan720/OnChip_SNN_Accelerator_Edge/blob/main/Presentation_Neuromorph_Accelerator.pdf)))
