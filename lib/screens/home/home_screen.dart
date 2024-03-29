import 'package:flutter/material.dart';
import 'package:meioambientemobile/components/vertical_spacer_box.dart';
import 'package:meioambientemobile/constants/style/constants.dart';
import 'package:meioambientemobile/core/api.dart';
import 'package:meioambientemobile/core/models/visits_model.dart';
import 'package:meioambientemobile/screens/details/details_screen.dart';
import 'package:meioambientemobile/screens/home/home_screen_controller.dart';
import 'package:meioambientemobile/screens/profile/profile_screen.dart';
import 'package:provider/provider.dart';
import 'components/visit_tile.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future _getAllVisits;
  @override
  void didChangeDependencies() {
    _getAllVisits = Api().getAllVisits(context);
    final controller = Provider.of<HomeScreenController>(context);
    controller.getAllVisits(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'lib/assets/images/logo.png',
            width: size.width * 0.2,
          ),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.account_circle_rounded,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () {
                Navigator.pushNamed(context, ProfileScreen.id);
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: FutureBuilder(
            future: _getAllVisits,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                final List<dynamic> dataList = snapshot.data as List<dynamic>;
                if (dataList.isEmpty) {
                  return const Center(
                    child: Text('Você não tem nenhuma visita ainda'),
                  );
                }
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'Todas as visitas: '.toUpperCase() +
                                  dataList.length.toString(),
                              style: kTitleStyles),
                          // InkWell(
                          //   onTap: () => showDialog(
                          //       context: context,
                          //       builder: (context) => const FilterDate()),
                          //   child: Row(children: [
                          //     const Icon(
                          //       Icons.filter_alt,
                          //       color: kDetailColor2,
                          //       size: 30,
                          //     ),
                          //     Text(
                          //       DateFormat("dd/MM/yyyy")
                          //           .format(DateTime.now()),
                          //       style: kdrawerText,
                          //     ),
                          //   ]),
                          // ),
                        ],
                      ),
                      const VerticalSpacerBox(size: SpacerSize.small),
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return const VerticalSpacerBox(
                                size: SpacerSize.tiny);
                          },
                          itemCount: dataList.length,
                          itemBuilder: ((context, index) {
                            var data = dataList[index];
                            VisitTile getVisitTilesInfo() {
                              if (data['denuncia'] != null) {
                                if (data['denuncia']['empresa'] == null) {
                                  final model = VisitsModel(
                                    companyId: 0,
                                    id: data['id'] ?? 0,
                                    text: data['denuncia']['texto'] ?? '',
                                    dueDate: data['data_marcada'],
                                    typeTitle: 'Denúncia',
                                    createdDate: data['created_at'],
                                    completedDate: data['data_realizada'],
                                    cep: '',
                                    city: '',
                                    neighborhood: '',
                                    number: '',
                                    state: '',
                                    street: data['denuncia']['endereco'] ?? '',
                                    complement: '',
                                    companyName: data['denuncia']
                                        ['empresa_nao_cadastrada'],
                                    phoneNumber: 'Não tem',
                                    cnpjOrCpf: 'Não tem',
                                    companyEmail: 'Não tem',
                                  );
                                  return VisitTile(
                                    completedDate: model.completedDate,
                                    title: 'title',
                                    visitDate: model.dueDate,
                                    empresa: 'empresa',
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return DetailsScreen(
                                          visitId: data['id'],
                                          denunciante: data['denuncia']
                                                  ['denunciante'] ??
                                              'Não há',
                                          requirementId: null,
                                          text: model.text,
                                          companyId: 1,
                                          denunciaId:
                                              data['denuncia']['id'] ?? 0,
                                          type: model.typeTitle,
                                          eventDate: model.dueDate,
                                          creationDate: model.createdDate!,
                                          completedDate: model.completedDate,
                                          adress: model.street,
                                          street: model.street,
                                          adressNumber: model.number,
                                          district: model.neighborhood,
                                          city: model.city,
                                          cep: model.cep,
                                          complement: model.complement,
                                          phoneNumber: model.phoneNumber,
                                          companyName: model.companyName,
                                          cnpj: model.cnpjOrCpf,
                                          email: model.companyEmail,
                                          name: 'model.name',
                                          profilePhotoUrl:
                                              'model.profilePhotoUrl',
                                        );
                                      }));
                                    },
                                    business: 'business',
                                    tipo: 'Denúncia',
                                    street: model.street,
                                    number: '',
                                    id: data['id'],
                                  );
                                } else {
                                  final model = VisitsModel(
                                    companyId: 0,
                                    id: data['id'] ?? 0,
                                    dueDate: data['data_marcada'],
                                    typeTitle: 'Denúncia',
                                    createdDate: data['created_at'],
                                    completedDate: data['data_realizada'],
                                    cep: data['denuncia']['empresa']['endereco']
                                            ['cep'] ??
                                        '',
                                    city: data['denuncia']['empresa']
                                            ['endereco']['cidade'] ??
                                        '',
                                    neighborhood: data['denuncia']['empresa']
                                            ['endereco']['bairro'] ??
                                        '',
                                    number: data['denuncia']['empresa']
                                            ['endereco']['numero'] ??
                                        '',
                                    state: data['denuncia']['empresa']
                                            ['endereco']['estado'] ??
                                        '',
                                    street: data['denuncia']['empresa']
                                            ['endereco']['rua'] ??
                                        '',
                                    complement: data['denuncia']['empresa']
                                            ['endereco']['complemento'] ??
                                        '',
                                    companyName: data['denuncia']['empresa']
                                            ['nome'] ??
                                        '',
                                    phoneNumber: data['denuncia']['empresa']
                                            ['telefone']['numero'] ??
                                        '',
                                    cnpjOrCpf: data['denuncia']['empresa']
                                            ['cpf_cnpj'] ??
                                        '',
                                    companyEmail: data['denuncia']['empresa']
                                            ['user']['email'] ??
                                        '',
                                  );
                                  return VisitTile(
                                    id: data['id'],
                                    title: 'Denúncia',
                                    visitDate: model.dueDate,
                                    completedDate: model.completedDate,
                                    empresa: 'empresa',
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return DetailsScreen(
                                          visitId: data['id'],
                                          requirementId: null,
                                          companyId: 1,
                                          denunciaId:
                                              data['denuncia']['id'] ?? 0,
                                          type: model.typeTitle,
                                          eventDate: model.dueDate,
                                          creationDate: model.createdDate!,
                                          completedDate: model.completedDate,
                                          adress: model.street,
                                          street: model.street,
                                          adressNumber: model.number,
                                          district: model.neighborhood,
                                          city: model.city,
                                          cep: model.cep,
                                          complement: model.complement,
                                          phoneNumber: model.phoneNumber,
                                          companyName: model.companyName,
                                          cnpj: model.cnpjOrCpf,
                                          email: model.companyEmail,
                                          name: 'model.name',
                                          profilePhotoUrl:
                                              'model.profilePhotoUrl',
                                        );
                                      }));
                                    },
                                    business: 'business',
                                    tipo: model.typeTitle,
                                    street: model.street,
                                    number: model.number,
                                  );
                                }
                              } else if (data['solicitacao_poda'] != null) {
                                final model = VisitsModel(
                                  companyId: 0,
                                  completedDate: data['data_realizada'],
                                  id: data['id'] ?? 0,
                                  dueDate: data['data_marcada'],
                                  typeTitle: 'Solicitação Poda',
                                  createdDate: data['created_at'],
                                  comment: data['comentario'],
                                  cep: data['solicitacao_poda']['endereco']
                                      ['cep'],
                                  city: data['solicitacao_poda']['endereco']
                                      ['cidade'],
                                  neighborhood: data['solicitacao_poda']
                                      ['endereco']['bairro'],
                                  number: data['solicitacao_poda']['endereco']
                                      ['numero'],
                                  state: data['solicitacao_poda']['endereco']
                                      ['estado'],
                                  street: data['solicitacao_poda']['endereco']
                                      ['rua'],
                                  complement: data['solicitacao_poda']
                                          ['endereco']['complemento'] ??
                                      '',
                                  companyName: data['solicitacao_poda']
                                      ['requerente']['user']['name'],
                                  phoneNumber: '',
                                  cnpjOrCpf: data['solicitacao_poda']
                                      ['requerente']['cpf'],
                                  companyEmail: data['solicitacao_poda']
                                      ['requerente']['user']['email'],
                                );
                                return VisitTile(
                                  id: data['id'],
                                  title: 'Solicitação Poda',
                                  visitDate: model.dueDate,
                                  completedDate: model.completedDate,
                                  empresa: model.companyName,
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return DetailsScreen(
                                        visitId: data['id'],
                                        requirementId: null,
                                        companyId: 1,
                                        denunciaId: 0,
                                        type: model.typeTitle,
                                        eventDate: model.dueDate,
                                        creationDate: model.createdDate!,
                                        completedDate: model.completedDate,
                                        adress: model.street,
                                        street: model.street,
                                        adressNumber: model.number,
                                        district: model.neighborhood,
                                        city: model.city,
                                        cep: model.cep,
                                        complement: model.complement,
                                        phoneNumber: model.phoneNumber,
                                        companyName: model.companyName,
                                        cnpj: model.cnpjOrCpf,
                                        email: model.companyEmail,
                                        name: 'model.name',
                                        profilePhotoUrl:
                                            'model.profilePhotoUrl',
                                      );
                                    }));
                                  },
                                  business: 'business',
                                  tipo: model.typeTitle,
                                  street: model.street,
                                  number: model.number,
                                );
                              } else if (data['requerimento'] != null) {
                                final model = VisitsModel(
                                  companyId: data['requerimento']['empresa_id'],
                                  requirementId: data['requerimento_id'],
                                  id: data['id'] ?? 0,
                                  dueDate: data['data_marcada'] ?? '',
                                  typeTitle: 'Requerimento',
                                  createdDate: data['created_at'] ?? '',
                                  completedDate: data['data_realizada'],
                                  cep: data['requerimento']['empresa']
                                          ['endereco']['cep'] ??
                                      '',
                                  city: data['requerimento']['empresa']
                                          ['endereco']['cidade'] ??
                                      '',
                                  neighborhood: data['requerimento']['empresa']
                                          ['endereco']['bairro'] ??
                                      '',
                                  number: data['requerimento']['empresa']
                                          ['endereco']['numero'] ??
                                      '',
                                  state: data['requerimento']['empresa']
                                          ['endereco']['estado'] ??
                                      '',
                                  street: data['requerimento']['empresa']
                                          ['endereco']['rua'] ??
                                      '',
                                  complement: data['requerimento']['empresa']
                                          ['endereco']['complemento'] ??
                                      '',
                                  companyName: data['requerimento']['empresa']
                                          ['nome'] ??
                                      '',
                                  phoneNumber: data['requerimento']['empresa']
                                          ['telefone']['numero'] ??
                                      '',
                                  cnpjOrCpf: data['requerimento']['empresa']
                                          ['cpf_cnpj'] ??
                                      '',
                                  companyEmail: data['requerimento']['empresa']
                                          ['user']['email'] ??
                                      '',
                                );
                                return VisitTile(
                                  id: data['id'],
                                  title: 'Requerimento',
                                  visitDate: DateTime.now().toString(),
                                  completedDate: model.completedDate,
                                  empresa: 'empresa',
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return DetailsScreen(
                                        visitId: data['id'],
                                        requirementId: model.requirementId,
                                        companyId: model.companyId,
                                        denunciaId: 0,
                                        type: model.typeTitle,
                                        eventDate: model.dueDate,
                                        creationDate: model.createdDate!,
                                        completedDate: model.completedDate,
                                        adress: model.street,
                                        street: model.street,
                                        adressNumber: model.number,
                                        district: model.neighborhood,
                                        city: model.city,
                                        cep: model.cep,
                                        complement: model.complement,
                                        phoneNumber: model.phoneNumber,
                                        companyName: model.companyName,
                                        cnpj: model.cnpjOrCpf,
                                        email: model.companyEmail,
                                        name: 'model.name',
                                        profilePhotoUrl:
                                            'model.profilePhotoUrl',
                                      );
                                    }));
                                  },
                                  business: 'business',
                                  tipo: model.typeTitle,
                                  street: model.street,
                                  number: model.number,
                                );
                              } else {
                                return VisitTile(
                                  id: 0,
                                  title: 'title',
                                  completedDate: null,
                                  visitDate: '',
                                  empresa: 'empresa',
                                  onTap: () {
                                    print('onTap');
                                  },
                                  business: 'business',
                                  tipo: 'tipo',
                                  street: '',
                                  number: '',
                                );
                              }
                            }

                            return Card(
                              child: getVisitTilesInfo(),
                            );
                          }),
                        ),
                      ),
                    ]);
              } else {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Carregando...'),
                    VerticalSpacerBox(size: SpacerSize.small),
                    CircularProgressIndicator(),
                  ],
                ));
              }
            }),
          ),
        ),
      ),
    );
  }
}
