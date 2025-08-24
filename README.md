# OnChip_SNN_Accelerator_Edge (LSM)
This design presents an on-chip spiking neural network (SNN) neuromorphic accelerator design deploying biologically inspired training for low power Edge-AI classification tasks.


# Brief Details

## Overall Architecture



- This repo contains a complete **Spiking Neural Network (SNN)** architecture with 3 layers:
  - **Input Layer**:
    - Contains one input neuron
    - Each input is 16 bits wide (word size)
  - **Hidden Layer (Reservoir Unit)**:
    - Contains 16 recurrent neurons
    - Each neuron includes an **on-chip unsupervised learning engine** for weight updates
  - **Output Layer (Training Unit)**:
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
- The hidden layer weight update learning engine contains unsupervised STDP learning Engine

# Unsupervised STDP weight update learning engine 

  <a href="https://raw.githubusercontent.com/muhammadfarhan720/web-profile/master/files/veriloga/veriloga_day01/STDP_GIF_speed_final.gif" target="_blank">
    <img src="https://raw.githubusercontent.com/muhammadfarhan720/web-profile/master/files/veriloga/veriloga_day01/STDP_GIF_speed_final.gif" 
         alt="STDP Learning Animation" 
         style="width: 100%; max-width: 600px; display: block; margin-top: 10px;">
  </a>
  <p><em>A visualization of STDP weight update mechanism between 4 pre-synaptic and 1 post-synaptic neuron</em></p>

  To implement the above Unsupervised STDP learning in hidden layer neuron learning engine, we designed the following hardware 

  <a href="https://raw.githubusercontent.com/muhammadfarhan720/web-profile/master/files/veriloga/veriloga_day01/SotA_STDP_LE_PL.png" target="_blank">
    <img src="https://raw.githubusercontent.com/muhammadfarhan720/web-profile/master/files/veriloga/veriloga_day01/SotA_STDP_LE_PL.png" 
         alt="On-chip local learning" 
         style="width: 100%; max-width: 600px; display: block; margin-bottom: 20px; margin-top: 10px;">
  </a>
  <p><em>Block-level RTL diagram of Unsupervised STDP learning logic integrated into a neuromorphic accelerator</em></p>

The Unsupervised learning engine works in following manner :

- The SIPO shift registers load the spike events (1/0) generate by the presynaptic neurons of previous layer and also the comparator generated output from the current neuron itself
- The contents of the shift registers are passed through the priority encoder to determine timing difference
- The timing difference sign determines whether weight should be added (Potentiation) or subtracted (Depression)
- The weight is updated using True-simple-Dual-port RAM memory in a read-then-write mode manner
  

## 📄 Project Presentation (PDF)

Click the image below to briefly overview the project presentation:

[![Project Report Preview](https://github.com/muhammadfarhan720/OnChip_SNN_Accelerator_Edge/blob/main/image/project_thumbnail.jpg))](https://github.com/muhammadfarhan720/OnChip_SNN_Accelerator_Edge/blob/main/Presentation_Neuromorph_Accelerator.pdf)))
