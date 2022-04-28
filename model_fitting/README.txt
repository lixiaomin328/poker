This package contains function needed to fit behavioral data for poker game with cursed equilibrium model, QRE model and level k model.\
\
All .m files are functions needed. \
solveQRE.m and modelfitting.m are two main functions one wants to run.\
\

We used processed density data in modelSource.mat to fit the model. This data needs to be updated easily if new data are collected. It is the pooled probability of betting over different card profiles. 


Start with modelfitting.m for estimate the model and plot out the fitting curve. Then you can dive deep into each function to see how this model works. This model is based on cognitive hierarchy model (see Camerer Ho 2004).

For qre model fitting, see solveQRE.m.

For cursed equilibrium, see CursedEquilibrium.m

