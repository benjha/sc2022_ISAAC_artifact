## Kelvin-Helmholtz instability

`kh_isaac_1gpu_ss.cfg` configuration file defines the V100 baseline for a domain of 256x256x256 in the strong scaling case. It uses about 15,827 MiB of GPU memory with the next additional parameters:

- particle.param: 
    - numParticlesPerDimension 2, 2, 1
- memory.param:
    - reservedGpuMemorySize = 2lu * 1024 * 1024 * 1024;
    - BYTES_EXCHANGE_X = 2 * 8  * 1024 * 1024;
    - BYTES_EXCHANGE_Y = 6 * 16 * 1024 * 1024;
    - BYTES_EXCHANGE_Z = 2 * 8  * 1024 * 1024;
