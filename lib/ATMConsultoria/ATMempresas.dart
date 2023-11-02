import 'package:flutter/material.dart';

class ATMempresas extends StatelessWidget {
  const ATMempresas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Empresas Menu"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/atmconsultoria/detalhe_empresa.png"),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text("Sobre a Empresa")
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi dolor magna, gravida non orci vitae, convallis congue nisl. Vestibulum sit amet est interdum, tristique est quis, blandit mauris. Etiam suscipit, odio ut tincidunt venenatis, eros dui malesuada ex, quis suscipit tellus mauris eu nibh. Quisque eu nunc in purus malesuada fermentum eget nec elit. Phasellus nec sodales quam. Fusce purus dui, dapibus at dictum sit amet, euismod vel velit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse potenti."
        
        "Donec elit nulla, gravida vel nisi sit amet, placerat suscipit neque. Praesent fermentum nunc ac eros commodo, id luctus risus gravida. Nulla hendrerit erat augue, at gravida lectus scelerisque sodales. Curabitur pulvinar nisl eu ipsum posuere commodo. Fusce vehicula, nunc quis ultrices varius, lacus dui elementum dolor, finibus tempus ex diam et quam. Aenean hendrerit malesuada urna dignissim ornare. Mauris quis libero sed ligula consectetur ultricies non gravida augue. Nunc in sapien sed nisi mollis sodales. Aliquam eget varius enim. Nullam convallis id nulla sit amet molestie. Vivamus iaculis quam vel rutrum posuere."
        
        "Nulla congue sagittis lacinia. Sed vitae auctor nisl. Sed eu lectus sed ligula porttitor fermentum. Pellentesque mollis consequat purus. Nullam lobortis leo sit amet lorem congue consectetur. Nunc et enim non mauris congue volutpat ut nec justo. In pharetra blandit congue. Fusce sit amet viverra dui. Praesent maximus metus vitae justo feugiat, quis faucibus turpis aliquam. Proin at urna quis erat condimentum mollis ut in metus. Pellentesque fermentum, tortor ut tincidunt aliquam, velit sem euismod erat, sit amet cursus dolor enim sed dui. Aenean vitae ex purus. Curabitur sollicitudin congue justo eget molestie."
        
        "Maecenas semper in justo id gravida. Nullam luctus eu mauris sit amet mollis. Pellentesque at sem ut metus finibus lacinia at quis nunc. Morbi vitae tempus velit. Praesent a congue leo, nec sollicitudin nibh. Etiam aliquet sapien vel dictum consequat. Sed eget laoreet eros. Pellentesque metus nisl, imperdiet sagittis eleifend id, laoreet ac purus. Donec hendrerit augue non luctus tristique. In eget interdum metus. Integer lobortis sapien id dui hendrerit, in tincidunt nulla varius. Duis eu justo interdum ipsum malesuada laoreet et sit amet lectus. Donec vitae hendrerit est. Interdum et malesuada fames ac ante ipsum primis in faucibus."
        
        "Etiam ac nulla et elit commodo posuere vitae quis turpis. Donec in ultricies sapien. Aenean vel tortor egestas, varius turpis sit amet, congue neque. Interdum et malesuada fames ac ante ipsum primis in faucibus. Fusce auctor non leo in ultricies. Maecenas tincidunt nulla non imperdiet convallis. Pellentesque vel dolor eget sem pretium elementum. Nunc libero mi, malesuada accumsan congue gravida, commodo aliquam dui. Vestibulum at lectus eleifend, suscipit purus et, malesuada mauris.")
            ]),
        ),
      ),
    );
  }
}