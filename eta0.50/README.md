# Exact Coherent Structures calculated in turbulent Taylor-Couette flow
Library of Exact Coherent Structures (ECSs) found in turbulent Taylor-Couette flow (TCF). The datasets stored in this repository compliment the following papers: <enter doi to paper(s)>. 

Folder `state-files` contains the TCF ECS state files in HDF5 file format. MATLAB functions are provided in folder `utils/` that can read the TCF HDF5 state files into MATLAB. 

The following information describes the data layout inside each HDF5 file. The top level group in the HDF5 file is `/tcf`. Inside the `/tcf` group are four additional groups called `field`, `domain`, `dns`, and `ecs`. 

## Examples
### Reading HDF5 state file in MATLAB
Using the supplied MATLAB function to read a HDF5 file returns a nested MATLAB structure.
```
tcf = read_tcf_HDF5_file(HDF5_file);
tcf = 

  struct with fields:

     field: [1×1 struct]
    domain: [1×1 struct]
       dns: [1×1 struct]
```
The first field `field` contains the spectral coefficients of the three velocity components
```
tcf.field
ans = 

  struct with fields:

    vr: [33×49×128 double]
    vt: [33×49×128 double]
    vz: [33×49×128 double]
```
The indices on the velocity components (e.g., vr(i,j,k)) are i (radial), j (axial), and k (azimuthal).

The second field `domain` contains parameters Taylor-Couette flow geometry information 
```
tcf.domain
ans = 

  struct with fields:

       nr: 33
       nz: 49
       nt: 129
        r: [1×33 double]
        t: [1×128 double]
        z: [1×49 double]
    gamma: 1
      eta: 0.5000
      Rei: 1200
      Reo: -1200
```
`nr`,`nz`, and `nt` represent the radial, axial, and azimithal dimension sizes, respectively. `r`, `t`, and `z` are the spatial grid coordinates. Finally, `gamma` and `eta` correspond to the aspect ratio and radius ratio, respectively, while `Rei` is the inner cylinder Reynolds number and `Reo` is the outer cylinder Reynolds number. Note, the end-caps are stationary. 

The third field `dns` contains information for the numerical time-integration scheme.
```
tcf.dns
ans = 

  struct with fields:

     dt: 3.1421e-06
    ndt: 2000
```
Here `ndt` is the total number of time-steps necessary to close orbit in one period (for RPOs) using a time-step of `dt`.

The fourth field `ecs` contains properties of the ECS.
```
tcf.ecs
ans = 

  struct with fields:

    discrete_symmetries: "None"
                 period: 0.00628424370161053
                  shift: 3.26876983540912
          solution_type: "Relative Periodic Orbit"
```
Relative equilibria and relative periodic orbits will contain both a `period` and a `shift` (corresponding to a rotation about the z-axis). To test the closure of a solution, integrate the ECS for one `period` and rotate the endpoint of that trajectory by the prescribed `shift`. This rotated state should, to a fair degree of accuracy, equal the initial condition.

### Display HDF5 state file layout
`tcf_HDF5_info.m` prints out the hierarchy layout of the Groups and datasets available in a TCF HDF5 file. For example,

```
>> tcf_HDF5_info('RPO01.h5')
HDF5 RPO01.h5 
Group '/tcf' 
    Group '/tcf/dns' 
        Dataset 'dt' 
        Dataset 'ndt' 
    Group '/tcf/domain' 
        Dataset 'Rei' 
        Dataset 'Reo' 
        Dataset 'eta' 
        Dataset 'gamma' 
        Dataset 'nr' 
        Dataset 'nt' 
        Dataset 'nz' 
        Dataset 'r' 
        Dataset 't' 
        Dataset 'z' 
    Group '/tcf/ecs' 
        Dataset 'discrete-symmetries' 
        Dataset 'period' 
        Dataset 'shift' 
        Dataset 'solution-type' 
    Group '/tcf/field' 
        Dataset 'vr' 
        Dataset 'vt' 
        Dataset 'vz'
```

# License
The data content of this project itself is licensed under the [Creative Commons Attribution 4.0 International](https://creativecommons.org/licenses/by/4.0/), and the underlying source code used to read and display that content is licensed under the [MIT license](LICENSE.txt).
