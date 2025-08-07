# OnChip_SNN_Accelerator_Edge
This design presents an on-chip spiking neural network (SNN) neuromorphic accelerator design deploying biologically inspired training for low power Edge-AI classification tasks.


# Brief Details

## Structure

--> This repo contains a full spiking neural network architecture that consists of 3 layers. 
--> The input layer has one input neuron with the size of a word (16 bit)
--> The hidden layer contains 16 recurrent neurons, all of which also have unsupervised weight update learning engine from on-chip training inside them
--> The readout layer contains two output neurons where each neuron contains a supervised weight update learning engine for on-chip supervised training

## Functions :

--> The input neuron sends input spike trains to the hidden layer
--> The hidden layer neurons start spiking after receiving input spikes and send their responses to readout and their own reccurent layer neurons
--> The hidden layer weights are updated for certain iteration using Unsupervised STDP learning
--> The hidden layer weights are frozen
--> The extracted states from the converged weight hidden layer are then sent to readout layer
--> The readout layer weights are trained using supervised STDP
--> Finally both the hidden and readout layer weights are frozen and the network is ready for inference


## 📄 Project Presentation (PDF)

Click the image below to briefly overview the project presentation:

[![Project Report Preview](https://github.com/muhammadfarhan720/OnChip_SNN_Accelerator_Edge/blob/main/image/project_thumbnail.jpg))](https://github.com/muhammadfarhan720/OnChip_SNN_Accelerator_Edge/blob/main/Presentation_Neuromorph_Accelerator.pdf)))
