.. _install-spack:

.. seealso::

   You will need to understand how to use `the terminal <http://www.ks.uiuc.edu/Training/Tutorials/Reference/unixprimer.html>`_.

.. warning::

   Our spack package is still in beta state and is continuously improved.
   Please feel free to report any issues that you might encounter.

Spack
-----

.. sectionauthor:: Axel Huebl

Preparation
^^^^^^^^^^^

First `install spack <http://spack.readthedocs.io/en/latest/getting_started.html>`_ itself via:

.. code-block:: bash

   # get spack
   git clone https://github.com/spack/spack.git $HOME/src/spack

   # activate the spack environment
   source $HOME/src/spack/share/spack/setup-env.sh

   # install a supported compiler
   spack compiler list | grep -q gcc@7.3.0 || spack install gcc@7.3.0 && spack load gcc@7.3.0 && spack compiler add

   # add the PIConGPU repository
   git clone https://github.com/ComputationalRadiationPhysics/spack-repo.git $HOME/src/spack-repo
   
   # add the new repo to spack
   spack repo add $HOME/src/spack-repo

.. note::

   When you open a terminal next time or log back into the machine, make sure to activate the spack environment again via:

   .. code-block:: bash

      source $HOME/src/spack/share/spack/setup-env.sh

Install
^^^^^^^

The installation of the latest version of PIConGPU is now as easy as:

.. code-block:: bash

   spack install picongpu %gcc@7.3.0

Use PIConGPU
^^^^^^^^^^^^

PIConGPU can now be loaded with

.. code-block:: bash

   spack load picongpu

For more information on *variants* of the ``picongpu`` package in spack run ``spack info picongpu`` and refer to the `official spack documentation <https://spack.readthedocs.io/>`_.

.. note::

   PIConGPU can also run *without a GPU*!
   For example, to use our OpenMP backend, just add ``backend=omp2b`` to the two commands above:
   
   .. code-block:: bash

      spack install picongpu backend=omp2b
      spack load picongpu backend=omp2b

